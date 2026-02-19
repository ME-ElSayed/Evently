import 'package:dartz/dartz.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/api/api_service.dart';
import 'package:get/get.dart';

class AuthRepository extends GetxService {
  late final ApiService _apiService;

  // Constructor injection
  AuthRepository() {
    _apiService = Get.find<ApiService>();
  }

  // ==================== REGISTER ====================

  Future<Either<ApiException, void>> register({
    required String name,
    required String username,
    required String email,
    required String password,
    required String governorate,
    String? profileImagePath,
  }) async {
    try {
      final response = await _apiService.register(
        name: name,
        username: username,
        email: email,
        password: password,
        governorate: governorate,
        profileImagePath: profileImagePath,
      );

      if (response['success'] == true) {
        return right(null);
      }

      // Backend returned success=false without throwing
      return left(
        ApiException(
          message: response['message'] ?? 'Registration failed',
          statusCode: null,
        ),
      );
    } on ApiException catch (e) {
      return left(e);
    }
  }

  // ==================== LOGIN ====================

  Future<Either<ApiException, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.login(
        email: email,
        password: password,
      );

      if (response['success'] == true) {
        return right(null);
      }

      return left(
        ApiException(
          message: response['message'] ?? 'Login failed',
          statusCode: null,
        ),
      );
    } on ApiException catch (e) {
      return left(e);
    }
  }

  // ==================== VERIFY USER (OTP) ====================

  Future<Either<ApiException, void>> verifyUser({
    required String email,
    required String otpCode,
  }) async {
    try {
      final response = await _apiService.verifyUser(
        email: email,
        otpCode: otpCode,
      );

      if (response['success'] == true) {
        return right(null);
      }

      return left(
        ApiException(
          message: response['message'] ?? 'Verification failed',
          statusCode: null,
        ),
      );
    } on ApiException catch (e) {
      return left(e);
    }
  }

  // ==================== RESEND OTP ====================

  Future<Either<ApiException, void>> resendVerificationOtp({
    required String email,
  }) async {
    try {
      final response = await _apiService.resendVerificationOtp(
        email: email,
      );

      if (response['success'] == true) {
        return right(null);
      }

      return left(
        ApiException(
          message: response['message'] ?? 'Failed to resend verification code',
          statusCode: null,
        ),
      );
    } on ApiException catch (e) {
      return left(e);
    }
  }

  // ==================== FORGOT PASSWORD ====================

  Future<Either<ApiException, void>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _apiService.forgotPassword(
        email: email,
      );

      if (response['success'] == true) {
        return right(null);
      }

      return left(
        ApiException(
          message: response['message'] ?? 'Failed to send reset code',
          statusCode: null,
        ),
      );
    } on ApiException catch (e) {
      return left(e);
    }
  }

 // ==================== VERIFY PASSWORD OTP ====================

Future<Either<ApiException, void>> verifyPasswordOtp({
  required String email,
  required String otpCode,
}) async {
  try {
    final response = await _apiService.verifyPasswordOtp(
      email: email,
      otpCode: otpCode,
    );

    if (response['success'] == true) {
      return right(null);
    }

    return left(
      ApiException(
        message: response['message'] ?? 'OTP verification failed',
        statusCode: null,
      ),
    );
  } on ApiException catch (e) {
    return left(e);
  }
}

// ==================== RESET PASSWORD ====================

Future<Either<ApiException, void>> resetPassword({
  required String password,
}) async {
  try {
    final response = await _apiService.resetPassword(
      password: password,
      // resetToken is automatically retrieved from SharedPreferences
    );

    if (response['success'] == true) {
      return right(null);
    }

    return left(
      ApiException(
        message: response['message'] ?? 'Password reset failed',
        statusCode: null,
      ),
    );
  } on ApiException catch (e) {
    return left(e);
  }
}

  // ==================== LOGOUT ====================

  Future<Either<ApiException, void>> logout() async {
    try {
      await _apiService.logout();
      return right(null);
    } on ApiException catch (e) {
      return left(e);
    }
  }
}
