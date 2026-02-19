import 'package:dio/dio.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'dio_client.dart';

class ApiService extends GetxService {
  late final DioClient _dioClient;
  late final SharedprefService _prefs;

  Future<ApiService> init() async {
    _dioClient = Get.find<DioClient>();
    _prefs = Get.find<SharedprefService>();
    return this;
  }

  // ==================== Generic HTTP Methods ====================

  /// GET request
  Future<dynamic> get(String endPoint,
      {Map<String, dynamic>? queryParams}) async {
    final response = await _dioClient.get(
      endPoint,
      queryParameters: queryParams,
    );
    return response.data;
  }

  /// POST request
  Future<dynamic> post(String endPoint, dynamic body) async {
    final response = await _dioClient.post(
      endPoint,
      data: body,
    );
    return response.data;
  }

  /// PUT request
  Future<dynamic> put(String endPoint, dynamic body) async {
    final response = await _dioClient.put(
      endPoint,
      data: body,
    );
    return response.data;
  }

  /// DELETE request
  Future<dynamic> delete(String endPoint, {dynamic body}) async {
    final response = await _dioClient.delete(
      endPoint,
      data: body,
    );
    return response.data;
  }

  /// PATCH request
  Future<dynamic> patch(String endPoint, dynamic body) async {
    final response = await _dioClient.patch(
      endPoint,
      data: body,
    );
    return response.data;
  }

  // ==================== Authentication Endpoints ====================

  /// Register new user
  Future<Map<String, dynamic>> register({
    required String name,
    required String username,
    required String email,
    required String password,
    required String governorate,
    String? profileImagePath,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'governorate': governorate,
      if (profileImagePath != null)
        'profileImage': await MultipartFile.fromFile(profileImagePath),
    });

    final response = await _dioClient.post(
      '/api/auth/register',
      data: formData,
    );

    if (response.data['success'] == true && response.data['data'] != null) {
      await _prefs.setUserData(response.data['data']['user']);
    }

    return response.data;
  }

  /// Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _dioClient.post(
      '/api/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.data['success'] == true && response.data['data'] != null) {
      final data = response.data['data'];

      await _prefs.saveTokens(
        accessToken: data['accessToken'],
        refreshToken: data['refreshToken'],
      );

      if (data['user'] != null) {
        await _prefs.setUserData(data['user']);
      }

      return response.data;
    }

    final error = response.data['error'];
    throw UnauthorizedException(
      message: error?['message'] ?? 'Invalid email or password',
    );
  }

  /// Logout user
  Future<void> logout() async {
    try {
      final refreshToken = _prefs.getRefreshToken();

      if (refreshToken != null) {
        await _dioClient.post(
          '/api/auth/logout',
          data: {'refreshToken': refreshToken},
        );
      }
    } finally {
      // Clear local data regardless of API response
      await _prefs.logout();
    }
  }

  // Refresh access token
  Future<Map<String, dynamic>> refreshToken() async {
    final refreshToken = _prefs.getRefreshToken();

    final response = await _dioClient.post(
      '/api/auth/refresh',
      data: {'refreshToken': refreshToken},
    );

    // Save new tokens
    if (response.data['success'] == true && response.data['data'] != null) {
      final data = response.data['data'];
      await _prefs.saveTokens(
        accessToken: data['accessToken'],
        refreshToken: data['refreshToken'],
      );
    }

    return response.data;
  }

  /// Resend verification OTP
  Future<Map<String, dynamic>> resendVerificationOtp({
    required String email,
  }) async {
    final response = await _dioClient.post(
      '/api/auth/resend-verification-otp',
      data: {'email': email},
    );

    return response.data;
  }

  /// Verify user with OTP
  Future<Map<String, dynamic>> verifyUser({
    required String email,
    required String otpCode,
  }) async {
    final response = await _dioClient.patch(
      '/api/auth/verify-user',
      data: {
        'email': email,
        'otpCode': otpCode,
      },
    );

    if (response.data['success'] == true && response.data['data'] != null) {
      final data = response.data['data'];

      // SAVE TOKENS
      if (data['accessToken'] != null && data['refreshToken'] != null) {
        await _prefs.saveTokens(
          accessToken: data['accessToken'],
          refreshToken: data['refreshToken'],
        );
      }

      // Update user verification status
      final userData = _prefs.getUserData();
      if (userData != null) {
        userData['isVerified'] = true;
        await _prefs.setUserData(userData);
      }
    }

    return response.data;
  }

  /// Request password reset OTP
  Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    final response = await _dioClient.post(
      '/api/auth/forgot-password',
      data: {'email': email},
    );

    return response.data;
  }

  /// Verify password reset OTP and get reset token
  Future<Map<String, dynamic>> verifyPasswordOtp({
    required String email,
    required String otpCode,
  }) async {
    final response = await _dioClient.post(
      '/api/auth/verify-otp',
      data: {
        'email': email,
        'otpCode': otpCode,
      },
    );

    // Save the reset token temporarily
    if (response.data['success'] == true && response.data['data'] != null) {
      final resetToken = response.data['data']['resetToken'];
      if (resetToken != null) {
        await _prefs.stringSetter(key: 'reset_token', value: resetToken);
      }
    }

    return response.data;
  }

  /// Reset password with reset token
  Future<Map<String, dynamic>> resetPassword({
    required String password,
    String? resetToken, // Make it optional since we can get it from storage
  }) async {
    // Get reset token from parameter or from storage
    final token = resetToken ?? _prefs.stringGetter(key: 'reset_token');

    if (token == null) {
      throw Exception('Reset token not found. Please verify OTP first.');
    }

    final response = await _dioClient.post(
      '/api/auth/reset-password',
      data: {
        'password': password,
        'resetToken': token,
      },
    );

    // Clear the reset token after successful password reset
    if (response.data['success'] == true) {
      await _prefs.remove('reset_token');
    }

    return response.data;
  }

////////////////invites/////////////////////////////////////////
  /// USER SEARCH
  Future<Map<String, dynamic>> searchUsers({
    required String query,
    required int page,
    required int limit,
  }) async {
    final response = await _dioClient.get(
      '/api/users',
      queryParameters: {
        'q': query,
        'page': page,
        'limit': limit,
      },
    );

    return response.data;
  }

  /// SEND INVITE
  Future<Map<String, dynamic>> sendInvite({
    required int eventId,
    required int userId,
    required String role,
    List<String>? permissions,
  }) async {
    final response = await _dioClient.post(
      '/api/events/$eventId/invites',
      data: {
        'receiverId': userId,
        'role': role,
        if (permissions != null) 'permissions': permissions,
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> getEventInvites({
    required int eventId,
    required int page,
    required int limit,
  }) async {
    final response = await _dioClient.get(
      '/api/events/$eventId/invites',
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> resendInvite({
    required int inviteId,
    required int eventId,
  }) async {
    final response = await _dioClient.post(
      '/api/events/$eventId/invites/$inviteId/resend',
    );

    return response.data;
  }

  Future<Map<String, dynamic>> getInviteNotifications({
    required int page,
    required int limit,
  }) async {
    final response = await _dioClient.get(
      '/api/notifications',
      queryParameters: {'page': page, 'limit': limit, 'type': 'invite'},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> markInviteNotificationsRead() async {
    final response = await _dioClient.patch(
      '/api/notifications/read-all?type=invite',
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getInviteById(int inviteId) async {
  final response = await _dioClient.get('/api/invites/$inviteId');
  return response.data;
}

/// ACCEPT INVITE
Future<Map<String, dynamic>> acceptInvite(int inviteId) async {
  final response = await _dioClient.post(
    '/api/invites/$inviteId/acceptance',
  );
  return response.data;
}

/// REJECT INVITE
Future<Map<String, dynamic>> rejectInvite(int inviteId) async {
  final response = await _dioClient.post(
    '/api/invites/$inviteId/rejection',
  );
  return response.data;
}

  ///
/////////////////////////////////////////////////////////
  // ==================== User Profile ====================

  /// Get current user profile
  Future<Map<String, dynamic>> getProfile() async {
    final response = await _dioClient.get('/api/users/me');

    // Update saved user data
    if (response.data['success'] == true && response.data['data'] != null) {
      await _prefs.setUserData(response.data['data']);
    }

    return response.data;
  }

  /// Update user profile
  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? username,
    String? governorate,
    String? profileImagePath,
  }) async {
    Map<String, dynamic> formData = {};

    if (name != null) formData['name'] = name;
    if (username != null) formData['username'] = username;
    if (governorate != null) formData['governorate'] = governorate;

    if (profileImagePath != null) {
      formData['profileImage'] = await MultipartFile.fromFile(profileImagePath);
    }

    // Use PATCH method with FormData for multipart data
    final response = await _dioClient.dio.patch(
      '/api/users/me',
      data: FormData.fromMap(formData),
    );

    // Update saved user data - API returns user directly in data.user
    if (response.data['success'] == true && response.data['data'] != null) {
      final userData = response.data['data']['user'];
      await _prefs.setUserData(userData);
    }

    return response.data;
  }

  // ==================== Events Management ====================

  /// Get event by ID
  Future<Map<String, dynamic>> getEventById(int eventId) async {
    final response = await _dioClient.get('/api/events/$eventId');
    return response.data;
  }

  /// CREATE EVENT
  Future<Map<String, dynamic>> createEvent({
    required String name,
    required String description,
    required double latitude,
    required double longitude,
    required String governorate,
    required DateTime startAt,
    required int duration,
    required int maxAttendees,
    required String visibility,
    required String paymentMethod,
    double? price,
    String? imagePath,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'governorate': governorate,
      'startAt': startAt.toUtc().toIso8601String(),
      'duration': duration,
      'maxAttendees': maxAttendees,
      'visibility': visibility,
      'paymentMethod': paymentMethod,
      if (price != null) 'price': price,
      if (imagePath != null) 'image': await MultipartFile.fromFile(imagePath),
    });

    final response = await _dioClient.post(
      '/api/events',
      data: formData,
    );

    return response.data;
  }

  /// GET EVENT ATTENDEES
  Future<Map<String, dynamic>> getEventAttendees({
    required int eventId,
    required int page,
    required int limit,
  }) async {
    final response = await _dioClient.get(
      '/api/events/$eventId/attendees',
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );

    return response.data;
  }

  /// REMOVE ATTENDEE
  Future<Map<String, dynamic>> removeAttendee({
    required int eventId,
    required int attendeeId,
  }) async {
    final response = await _dioClient.delete(
      '/api/events/$eventId/attendees/$attendeeId',
    );

    return response.data;
  }

  /// GET EVENT Managers
  Future<Map<String, dynamic>> getEventManagers({
    required int eventId,
    required int page,
    required int limit,
  }) async {
    final response = await _dioClient.get(
      '/api/events/$eventId/managers',
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );

    return response.data;
  }

  /// REMOVE Manager
  Future<Map<String, dynamic>> removeManager({
    required int eventId,
    required int managerId,
  }) async {
    final response = await _dioClient.delete(
      '/api/events/$eventId/managers/$managerId',
    );

    return response.data;
  }

  Future<Map<String, dynamic>> verifyAttendance({
    required int eventId,
    required String attendanceCode,
  }) async {
    final response =
        await _dioClient.post('/api/events/$eventId/verify-attendance', data: {
      "attendanceCode": attendanceCode,
    });

    return response.data;
  }

  Future<Map<String, dynamic>> leaveEvent({
    required int eventId,
  }) async {
    final response = await _dioClient.delete(
      '/api/events/$eventId/members/me',
    );

    return response.data;
  }

  // ==================== User Events (Paginated) ====================

  /// Search/Filter events with pagination, sorting, and name search
  Future<Map<String, dynamic>> searchEvents({
    String? governorate,
    String? sort,
    String? name,
    int page = 1,
    int limit = 10,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (governorate != null && governorate.isNotEmpty) {
      queryParams['governorate'] = governorate;
    }

    if (sort != null && sort.isNotEmpty) {
      queryParams['sort'] = sort;
    }

    if (name != null && name.isNotEmpty) {
      queryParams['name'] = name;
    }

    final response = await _dioClient.get(
      '/api/events',
      queryParameters: queryParams,
    );

    return response.data;
  }

  Future<Map<String, dynamic>> getOrganizedEvents({
    required int page,
    required int limit,
  }) async {
    final response = await _dioClient.get(
      '/api/users/me/events/organized',
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getAttendedEvents({
    required int page,
    required int limit,
  }) async {
    final response = await _dioClient.get(
      '/api/users/me/events/attended',
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );
    return response.data;
  }

  /// ATTEND EVENT
  Future<Map<String, dynamic>> attendEvent(int eventId) async {
    final response = await _dioClient.post(
      '/api/events/$eventId/attendees',
    );
    return response.data;
  }

  /// Update event
  Future<Map<String, dynamic>> updateEvent({
    required int eventId,
    String? name,
    String? description,
    double? latitude,
    double? longitude,
    String? governorate,
    DateTime? startAt,
    int? duration,
    String? state,
    int? maxAttendees,
    String? visibility,
    String? imagePath,
  }) async {
    final Map<String, dynamic> data = {};

    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    if (governorate != null) data['governorate'] = governorate;
    if (state != null) data['state'] = state;
    if (startAt != null) {
      data['startAt'] = startAt.toUtc().toIso8601String();
    }
    if (duration != null) data['duration'] = duration;
    if (maxAttendees != null) data['maxAttendees'] = maxAttendees;
    if (visibility != null) data['visibility'] = visibility;

    // If image is provided, use FormData
    if (imagePath != null) {
      data['image'] = await MultipartFile.fromFile(imagePath);

      final response = await _dioClient.dio.patch(
        '/api/events/$eventId',
        data: FormData.fromMap(data),
      );

      return response.data;
    } else {
      // Use pure JSON (no FormData)
      final response = await _dioClient.patch(
        '/api/events/$eventId',
        data: data,
      );

      return response.data;
    }
  }

  // ==================== Notifications ====================

  /// Get notifications (paginated)
  Future<Map<String, dynamic>> getGeneralNotifications({
    required int page,
    required int limit,
  }) async {
    final response = await _dioClient.get(
      '/api/notifications',
      queryParameters: {'page': page, 'limit': limit, 'type': 'general'},
    );
    return response.data;
  }

  /// Register FCM token
  Future<Map<String, dynamic>> registerFcmToken(String token) async {
    final response = await _dioClient.post(
      '/api/notifications/register-token',
      data: {'token': token},
    );
    return response.data;
  }

  /// Mark all notifications as read
  Future<Map<String, dynamic>> markAllNotificationsRead() async {
    final response = await _dioClient.patch(
      '/api/notifications/read-all',
    );
    return response.data;
  }

  /// Get unread notifications count
  Future<Map<String, dynamic>> getUnreadNotificationsCount(String type) async {
    final response = await _dioClient.get('/api/notifications/unread-count',
        queryParameters: {'type': type});
    return response.data;
  }

  /// Delete notification
  Future<Map<String, dynamic>> deleteNotification(int notificationId) async {
    final response =
        await _dioClient.delete('/api/notifications/$notificationId');
    return response.data;
  }
}
