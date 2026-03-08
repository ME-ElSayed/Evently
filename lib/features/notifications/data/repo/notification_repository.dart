// features/notifications/data/repo/notification_repo.dart

import 'package:dartz/dartz.dart';
import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_service.dart';
import 'package:eventsmanager/features/notifications/data/models/notification_model.dart';
import 'package:get/get.dart';

abstract class NotificationRepository {
  Future<Either<ApiException, List<NotificationModel>>> getNotifications({
    required int page,
    required int limit,
  });

  Future<Either<ApiException, int>> getUnreadCount(String type);

  Future<Either<ApiException, void>> markAllAsRead();

  Future<Either<ApiException, void>> deleteNotification(int id);

  Future<Either<ApiException, void>> registerFcmToken(String token);
}

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiService _api = Get.find<ApiService>();

  @override
  Future<Either<ApiException, List<NotificationModel>>> getNotifications({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.getGeneralNotifications(
        page: page,
        limit: limit,
      );

      final notifications = (response['data']['notifications'] as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList();

      return Right(notifications);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, int>> getUnreadCount(String type) async {
    try {
      final response = await _api.getUnreadNotificationsCount(type);
      return Right(response['data']['count']);
    } on ApiException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ApiException, void>> markAllAsRead() async {
    try {
      await _api.markAllNotificationsRead();
      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ApiException, void>> deleteNotification(int id) async {
    try {
      await _api.deleteNotification(id);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ApiException, void>> registerFcmToken(String token) async {
    try {
      await _api.registerFcmToken(token);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    }
  }
}
