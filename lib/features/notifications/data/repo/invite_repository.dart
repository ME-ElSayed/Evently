import 'package:dartz/dartz.dart';
import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_service.dart';
import 'package:eventsmanager/features/notifications/data/models/invite_notification_model.dart';
import 'package:eventsmanager/features/notifications/data/models/notification_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

abstract class InviteRepository {
  Future<Either<ApiException, List<NotificationModel>>> getInviteNotifications({
    required int page,
    required int limit,
  });

  Future<Either<ApiException, void>> markInviteAsRead();
  Future<Either<ApiException, int>> getUnreadCount(String type);
  Future<Either<ApiException, InviteNotificationModel>> getInviteById(int inviteId);

  /// Returns attendanceCode for ATTENDEE role, null for MANAGER role
  Future<Either<ApiException, String?>> acceptInvite(int inviteId);
  Future<Either<ApiException, void>> rejectInvite(int inviteId);
}

class InviteRepositoryImpl implements InviteRepository {
  final ApiService _api = Get.find<ApiService>();

  @override
  Future<Either<ApiException, List<NotificationModel>>> getInviteNotifications({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.getInviteNotifications(page: page, limit: limit);
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
  Future<Either<ApiException, void>> markInviteAsRead() async {
    try {
      await _api.markInviteNotificationsRead();
      return const Right(null);
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
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, InviteNotificationModel>> getInviteById(int inviteId) async {
    try {
      final response = await _api.getInviteById(inviteId);
      return Right(InviteNotificationModel.fromJson(response['data']['invite']));
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, String?>> acceptInvite(int inviteId) async {
    try {
      final response = await _api.acceptInvite(inviteId);
      final code = response['data']?['attendanceCode'] as String?;
      return Right(code);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> rejectInvite(int inviteId) async {
    try {
      await _api.rejectInvite(inviteId);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}