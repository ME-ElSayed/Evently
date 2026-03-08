import 'package:eventsmanager/core/api/api_exceptions.dart';

enum ApiStatus {
  idle, // initial / none
  loading, // request in progress
  success, // request success
  offline, // no internet
  timeout, // request timeout
  unauthorized, // 401
  forbidden, // 403
  notFound, // 404
  validation, // 400 INVALID_DATA
  serverError, // 5xx
  error, // generic failure
}

class ApiStatusMapper {
  static ApiStatus fromException(ApiException e) {
    if (e is NetworkException) return ApiStatus.offline;
    if (e is TimeoutException) return ApiStatus.timeout;
    if (e is InvalidCredentialsException) return ApiStatus.validation;
    if (e is UnauthorizedException) return ApiStatus.unauthorized;
    if (e is ForbiddenException) return ApiStatus.forbidden;
    if (e is NotFoundException) return ApiStatus.notFound;
    if (e is ValidationException) return ApiStatus.validation;
    if (e is ServerException) return ApiStatus.serverError;

    return ApiStatus.error;
  }
}
