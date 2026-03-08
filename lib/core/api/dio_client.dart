import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_error_handler.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';

class DioClient extends GetxService {
  late final Dio dio;
  final String baseUrl;
  final VoidCallback? onTokenRefreshFailed;

  DioClient({
    required this.baseUrl,
    this.onTokenRefreshFailed,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(minutes: 3),
        receiveTimeout: const Duration(minutes: 3),
        sendTimeout: const Duration(minutes: 3),
        headers: const {
          'Accept': 'application/json',
        },
      ),
    );

    // Add Auth Interceptor
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        onTokenRefreshFailed: onTokenRefreshFailed,
      ),
    );

    // Add Log Interceptor
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  // ==================== HTTP METHODS ====================

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      // Pre-check token for FormData requests (cannot be retried)
      if (data is FormData && !_isAuthEndpoint(path)) {
        await _ensureValidToken();
      }
      return await dio.post(path, data: data);
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      // Pre-check token for FormData requests (cannot be retried)
      if (data is FormData && !_isAuthEndpoint(path)) {
        await _ensureValidToken();
      }
      return await dio.put(path, data: data);
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }

  Future<Response> patch(String path, {dynamic data}) async {
    try {
      // Pre-check token for FormData requests (cannot be retried)
      if (data is FormData && !_isAuthEndpoint(path)) {
        await _ensureValidToken();
      }
      return await dio.patch(path, data: data);
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await dio.delete(path, data: data);
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }

  // ==================== TOKEN PRE-CHECK (for FormData only) ====================
  
  Future<void> _ensureValidToken() async {
    final prefs = Get.find<SharedprefService>();
    final accessToken = prefs.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw UnauthorizedException(message: 'No access token');
    }

    // Check if token is expired
    if (_isTokenExpired(accessToken)) {
      final refreshToken = prefs.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        throw UnauthorizedException(message: 'No refresh token');
      }

      // Refresh token before sending FormData
      final response = await dio.post(
        '/api/auth/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Authorization': null}),
      );

      final data = response.data['data'];
      await prefs.saveTokens(
        accessToken: data['accessToken'],
        refreshToken: data['refreshToken'],
      );
    }
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = json.decode(
        utf8.decode(
          base64Url.decode(
            base64Url.normalize(parts[1]),
          ),
        ),
      );

      final exp = payload['exp'];
      if (exp == null) return true;

      // Add 30 second buffer
      final expiryTime = exp * 1000;
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      
      return currentTime >= (expiryTime - 30 * 1000);
    } catch (e) {
      debugPrint('Error checking token expiration: $e');
      return true; // Assume expired if we can't parse
    }
  }

  bool _isAuthEndpoint(String path) {
    return path.contains('/auth/login') ||
        path.contains('/auth/register') ||
        path.contains('/auth/verify-user') ||
        path.contains('/auth/resend-verification-otp') ||
        path.contains('/auth/forgot-password') ||
        path.contains('/auth/verify-otp') ||
        path.contains('/auth/reset-password') ||
        path.contains('/auth/logout') ||
        path.contains('/auth/refresh');
  }
}

// ============================================================================
// AUTH INTERCEPTOR - Following PDF Document Pattern
// ============================================================================

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final VoidCallback? onTokenRefreshFailed;

  bool _isRefreshing = false;
  final List<Completer<void>> _waitingRequests = [];

  AuthInterceptor({
    required this.dio,
    this.onTokenRefreshFailed,
  });

  // ==================== ON REQUEST ====================

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // Skip adding token for auth endpoints
    if (_isAuthEndpoint(options.path)) {
      return handler.next(options);
    }

    // Get access token from SharedPreferences
    final prefs = Get.find<SharedprefService>();
    final accessToken = prefs.getAccessToken();

    // Add Authorization header if token exists
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  // ==================== ON ERROR ====================
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final requestOptions = err.requestOptions;

    // Check if error is 401 Unauthorized and not an auth endpoint
    if (statusCode == 401 && !_isAuthEndpoint(requestOptions.path)) {
      
      //  CRITICAL: Never retry FormData requests
      // FormData cannot be reused after it's been sent
      if (requestOptions.data is FormData) {
        debugPrint(' FormData request failed with 401 - Cannot retry');
        debugPrint(' Refreshing token for next request...');
        
        try {
          // Refresh token for future requests
          await _handleTokenRefresh();
        } catch (e) {
          debugPrint('Token refresh failed: $e');
        }
        
        // Logout user - they need to retry manually
        _logout();
        return handler.reject(err);
      }

      try {
       
        final failedRequest = requestOptions;

       
        await _handleTokenRefresh();

        
        final prefs = Get.find<SharedprefService>();
        final newAccessToken = prefs.getAccessToken();

        if (newAccessToken == null || newAccessToken.isEmpty) {
          throw UnauthorizedException(message: 'No access token after refresh');
        }

       
        failedRequest.headers['Authorization'] = 'Bearer $newAccessToken';

    
        final response = await dio.fetch(failedRequest);
        
        // Return the successful response
        return handler.resolve(response);
      } catch (e) {
        debugPrint('Token refresh failed: $e');
        _logout();
        return handler.reject(err);
      }
    }

    // For other errors, continue normally
    handler.next(err);
  }

  // ==================== TOKEN REFRESH LOGIC ====================
  Future<void> _handleTokenRefresh() async {
    // If already refreshing, wait for it to complete
    if (_isRefreshing) {
      final completer = Completer<void>();
      _waitingRequests.add(completer);
      return completer.future;
    }

    _isRefreshing = true;

    try {
      final prefs = Get.find<SharedprefService>();
      final refreshToken = prefs.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        throw UnauthorizedException(message: 'No refresh token available');
      }

      // Call refresh token endpoint
      final response = await dio.post(
        '/api/auth/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(
          headers: {'Authorization': null}, // Don't send token to refresh endpoint
        ),
      );

      // Extract new tokens from response
      final data = response.data['data'];
      final newAccessToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];

      // Save new tokens
      await prefs.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      // Complete all waiting requests
      for (var completer in _waitingRequests) {
        completer.complete();
      }
      _waitingRequests.clear();
    } catch (e) {
      // Fail all waiting requests
      for (var completer in _waitingRequests) {
        completer.completeError(e);
      }
      _waitingRequests.clear();
      rethrow;
    } finally {
      _isRefreshing = false;
    }
  }

  // ==================== LOGOUT ====================
  void _logout() {
    final prefs = Get.find<SharedprefService>();
    prefs.clearTokens();
    prefs.clearUserData();
    onTokenRefreshFailed?.call();
  }

  // ==================== HELPER METHODS ====================
  
  /// Check if the endpoint is an authentication endpoint
  bool _isAuthEndpoint(String path) {
    return path.contains('/auth/login') ||
        path.contains('/auth/register') ||
        path.contains('/auth/verify-user') ||
        path.contains('/auth/resend-verification-otp') ||
        path.contains('/auth/forgot-password') ||
        path.contains('/auth/verify-otp') ||
        path.contains('/auth/reset-password') ||
        path.contains('/auth/logout') ||
        path.contains('/auth/refresh');
  }
}