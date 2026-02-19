
/// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? code;
  final dynamic details;

  ApiException({
    required this.message,
    this.statusCode,
    this.code,
    this.details,
  });

  @override
  String toString() => message;
}

/// Exception for network connectivity issues
class NetworkException extends ApiException {
  NetworkException({String? message})
      : super(
          message: message ?? 'No internet connection. Please check your network.',
          statusCode: null,
          code: 'NETWORK_ERROR',
        );
}

/// Exception for request timeout
class TimeoutException extends ApiException {
  TimeoutException({String? message})
      : super(
          message: message ?? 'Request timeout. Please try again.',
          statusCode: 408,
          code: 'TIMEOUT',
        );
}

/// Exception for invalid credentials
class InvalidCredentialsException extends ApiException {
  InvalidCredentialsException({String? message})
      : super(
          message: message ?? 'Invalid email or password.',
          statusCode: 401,
          code: 'INVALID_CREDENTIALS',
        );
}

/// Exception for unauthorized access (401)
class UnauthorizedException extends ApiException {
  UnauthorizedException({String? message})
      : super(
          message: message ?? 'Unauthorized. Please login again.',
          statusCode: 401,
          code: 'UNAUTHORIZED',
        );
}

/// Exception for forbidden access (403)
class ForbiddenException extends ApiException {
  ForbiddenException({String? message})
      : super(
          message: message ?? 'Access forbidden.',
          statusCode: 403,
          code: 'FORBIDDEN',
        );
}

/// Exception for not found (404)
class NotFoundException extends ApiException {
  NotFoundException({String? message, String? code})
      : super(
          message: message ?? 'Resource not found.',
          statusCode: 404,
          code: code ?? 'NOT_FOUND',
        );
}

/// Exception for server errors (500+)
class ServerException extends ApiException {
  ServerException({String? message})
      : super(
          message: message ?? 'Server error. Please try again later.',
          statusCode: 500,
          code: 'SERVER_ERROR',
        );
}

/// Exception for bad request (400)
class BadRequestException extends ApiException {
  BadRequestException({String? message, String? code, super.details})
      : super(
          message: message ?? 'Bad request.',
          statusCode: 400,
          code: code ?? 'BAD_REQUEST',
        );
}

/// Exception for validation errors (400 with INVALID_DATA code)
class ValidationException extends ApiException {
  ValidationException({String? message, super.details})
      : super(
          message: message ?? 'Validation failed.',
          statusCode: 400,
          code: 'INVALID_DATA',
        );
}

/// Exception for user not found
class UserNotFoundException extends ApiException {
  UserNotFoundException({String? message})
      : super(
          message: message ?? 'User not found.',
          statusCode: 404,
          code: 'USER_NOT_FOUND',
        );
}

/// Exception for invalid OTP
class InvalidOtpException extends ApiException {
  InvalidOtpException({String? message})
      : super(
          message: message ?? 'Invalid or expired OTP code.',
          statusCode: 400,
          code: 'INVALID_OTP',
        );
}



/// Exception for unverified user
class UnverifiedUserException extends ApiException {
  UnverifiedUserException({String? message})
      : super(
          message: message ?? 'Please verify your email first.',
          statusCode: 403,
          code: 'UNVERIFIED_USER',
        );
}

