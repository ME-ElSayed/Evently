import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';

class ApiErrorHandler {
  static ApiException handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException();

        case DioExceptionType.connectionError:
          if (error.error is SocketException) {
            return NetworkException();
          }
          return NetworkException(message: error.message);

        case DioExceptionType.cancel:
          return ApiException(message: 'Request was cancelled');

        case DioExceptionType.badResponse:
          return _handleResponseError(error.response);

        case DioExceptionType.badCertificate:
          return ApiException(message: 'Certificate verification failed');

        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return NetworkException();
          }
          return ApiException(
              message: error.message ?? 'Unknown error occurred');
      }
    }

    return ApiException(message: error.toString());
  }

  // ==================== RESPONSE ERROR ====================

  static ApiException _handleResponseError(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    final message = _extractErrorMessage(data);
    final errorCode = _extractErrorCode(data);
    final details = _extractErrorDetails(data);

    // ------------------------------------------------------
    // DOMAIN ERRORS (HIGHEST PRIORITY)
    // ------------------------------------------------------
    if (errorCode != null) {
      switch (errorCode) {
        case 'INVALID_CREDENTIALS':
        case 'AUTH_FAILED':
          return InvalidCredentialsException(message: message);

        case 'UNVERIFIED_USER':
          return UnverifiedUserException(message: message);

        case 'USER_NOT_FOUND':
          return UserNotFoundException(message: message);

        case 'INVALID_OTP':
          return InvalidOtpException(message: message);

        case 'INVALID_DATA':
          return ValidationException(message: message, details: details);
      }
    }

    // ------------------------------------------------------
    // STATUS-BASED FALLBACK (NO DOMAIN CODE)
    // ------------------------------------------------------
    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: message,
          code: errorCode,
          details: details,
        );

      case 401:
        return UnauthorizedException(
          message: message.isNotEmpty
              ? message
              : 'Session expired. Please login again.',
        );

      case 403:
        return ForbiddenException(message: message);

      case 404:
        return NotFoundException(message: message, code: errorCode);

      case 500:
      case 501:
      case 502:
      case 503:
        return ServerException(message: message);
    }

    // ------------------------------------------------------
    //  FINAL FALLBACK
    // ------------------------------------------------------
    return ApiException(
      message: message.isNotEmpty ? message : 'Unexpected error occurred',
      statusCode: statusCode,
      code: errorCode,
      details: details,
    );
  }

  // ==================== HELPERS (UNCHANGED) ====================

  static String _extractErrorMessage(dynamic data) {
    if (data is Map && data['error'] is Map) {
      return data['error']['message']?.toString() ?? '';
    }
    return '';
  }

  static String? _extractErrorCode(dynamic data) {
    if (data is Map && data['error'] is Map) {
      return data['error']['code']?.toString();
    }
    return null;
  }

  static dynamic _extractErrorDetails(dynamic data) {
    if (data is Map && data['error'] is Map) {
      return data['error']['details'];
    }
    return null;
  }

  // ==================== USER FRIENDLY MESSAGE ====================

  static String getUserFriendlyMessage(ApiException e) {
    if (e is NetworkException) {
      return 'Please check your internet connection.';
    }
    if (e is TimeoutException) {
      return 'Request timed out. Please try again.';
    }
    if (e is InvalidCredentialsException) {
      return e.message;
    }
    if (e is UnverifiedUserException) {
      return e.message;
    }
    if (e is UnauthorizedException) {
      return e.message;
    }
    if (e is ValidationException) {
      return _formatValidationErrors(e.details) ?? e.message;
    }
    return e.message.replaceAll("_", " ");
  }

  static String? _formatValidationErrors(dynamic details) {
    if (details is List) {
      return details
          .whereType<Map>()
          .map((e) => '${e['field']}: ${e['code']}')
          .join(', ');
    }
    return null;
  }
}
