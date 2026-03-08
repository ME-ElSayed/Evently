import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/core/api/api_error_handler.dart';
import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';
import 'package:eventsmanager/features/events/presentation/manager/createdEvents/pagination_controller.dart';
import 'package:eventsmanager/features/notifications/data/models/notification_model.dart';
import 'package:eventsmanager/features/notifications/data/repo/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends PaginationController<NotificationModel> {
  final NotificationRepository _repo = Get.find<NotificationRepository>();
  final SharedprefService pref = Get.find<SharedprefService>();

  // API state
  final apiStatusNotifications = ApiStatus.idle.obs;
  ApiException? notificationException;

  final apiStatusRead = ApiStatus.idle.obs;
  ApiException? readException;

  final apiStatusDelete = ApiStatus.idle.obs;
  ApiException? deleteException;

  // Unread count
  final unreadTotalCount = 0.obs;
  final unreadGeneralCount = 0.obs;

  NotificationsController() : super(limit: 10);
  @override
  void onInit() {
    fetchUnreadCount();
    fetchUnreadTotalCount();
    super.onInit();
  }

  /* ================= PAGINATION ================= */

  @override
  Future<List<NotificationModel>> fetchPage(int page, int limit) async {
    apiStatusNotifications.value = ApiStatus.loading;
    notificationException = null;

    final result = await _repo.getNotifications(
      page: page,
      limit: limit,
    );

    return result.fold(
      (exception) {
        notificationException = exception;
        apiStatusNotifications.value = ApiStatusMapper.fromException(exception);
        hasMore.value = false;
        return <NotificationModel>[];
      },
      (notifications) {
        apiStatusNotifications.value = ApiStatus.success;
        return notifications;
      },
    );
  }

  /* ================= REFRESH ================= */

  Future<void> refreshNotifications() async {
    await fetchInitial();
    await fetchUnreadCount();
    await fetchUnreadTotalCount();
  }

  /* ================= UNREAD COUNT ================= */

  Future<void> fetchUnreadCount() async {
    final result = await _repo.getUnreadCount("general");

    result.fold(
      (_) {},
      (count) => unreadGeneralCount.value = count,
    );
  }

  Future<void> fetchUnreadTotalCount() async {
    final result = await _repo.getUnreadCount("all");

    result.fold(
      (_) {},
      (count) => unreadTotalCount.value = count,
    );
  }

  /* ================= MARK AS READ ================= */

  Future<void> markAllAsRead() async {
    apiStatusRead.value = ApiStatus.loading;
    readException = null;
    final result = await _repo.markAllAsRead();

    result.fold(
      (exception) {
        readException = exception;
        apiStatusRead.value = ApiStatusMapper.fromException(exception);
        showMessage(
          " Failed",
          ApiErrorHandler.getUserFriendlyMessage(exception),
          Colors.red,
          Colors.black,
        );
      },
      (_) {
        apiStatusRead.value = ApiStatus.success;
        unreadGeneralCount.value = 0;
        refreshNotifications();
      },
    );
  }

  /* ================= DELETE ================= */

  Future<void> deleteNotification(int id) async {
    apiStatusDelete.value = ApiStatus.loading;
    deleteException = null;

    final result = await _repo.deleteNotification(id);

    result.fold(
      (exception) {
        // rollback
        apiStatusDelete.value = ApiStatusMapper.fromException(exception);
        showMessage(
          " Failed",
          ApiErrorHandler.getUserFriendlyMessage(exception),
          Colors.red,
          Colors.black,
        );
      },
      (_) {
        apiStatusDelete.value = ApiStatus.success;
        refreshNotifications();
      },
    );
  }
}
