import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/services/api/api_error_handler.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/api/api_status.dart';
import 'package:eventsmanager/features/events/presentation/manager/createdEvents/pagination_controller.dart';
import 'package:eventsmanager/features/notifications/data/models/notification_model.dart';
import 'package:eventsmanager/features/notifications/data/repo/invite_repository.dart';
import 'package:eventsmanager/features/notifications/presentation/manager/notification/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteNotificationController
    extends PaginationController<NotificationModel> {
  final InviteRepository _repo = Get.find<InviteRepository>();

  // API state
  final apiStatusNotifications = ApiStatus.idle.obs;
  ApiException? notificationException;

  final apiStatusRead = ApiStatus.idle.obs;
  ApiException? readException;

  final apiStatusInviteDetail = ApiStatus.idle.obs;
  ApiException? inviteDetailException;

  RxMap<int, ApiStatus> acceptApiStatus = <int, ApiStatus>{}.obs;
  ApiException? acceptException;

  RxMap<int, ApiStatus> rejectApiStatus = <int, ApiStatus>{}.obs;
  ApiException? rejectException;

  // Unread count
  final unreadInviteCount = 0.obs;
  InviteNotificationController() : super(limit: 10);

  @override
  void onInit() {
    fetchIviteUnreadCount();
    super.onInit();
  }
  /* ================= PAGINATION ================= */

  @override
  Future<List<NotificationModel>> fetchPage(int page, int limit) async {
    apiStatusNotifications.value = ApiStatus.loading;
    notificationException = null;

    final result = await _repo.getInviteNotifications(
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

  //unread
  Future<void> fetchIviteUnreadCount() async {
    final result = await _repo.getUnreadCount("invite");

    result.fold(
      (_) {},
      (count) => unreadInviteCount.value = count,
    );
  }

  Future<void> openInvite(int inviteId) async {
    apiStatusInviteDetail.value = ApiStatus.loading;
    inviteDetailException = null;

    final result = await _repo.getInviteById(inviteId);

    result.fold(
      (exception) {
        inviteDetailException = exception;
        apiStatusInviteDetail.value = ApiStatusMapper.fromException(exception);
        showMessage(
          "Failed",
          ApiErrorHandler.getUserFriendlyMessage(exception),
          Colors.red,
          Colors.black,
        );
      },
      (invite) {
        apiStatusInviteDetail.value = ApiStatus.success;
        Get.toNamed(
          AppRoutes.eventDetails,
          arguments: {
            'eventModel': invite.event,
            'invite': invite,
          },
        );
      },
    );
  }

  /* ================= REFRESH ================= */

  Future<void> refreshNotifications() async {
    await fetchInitial();
    await fetchIviteUnreadCount();
    await Get.find<NotificationsController>().fetchUnreadTotalCount();
  }

  /* ================= MARK AS READ ================= */

  Future<void> markAllAsRead() async {
    apiStatusRead.value = ApiStatus.loading;
    readException = null;
    final result = await _repo.markInviteAsRead();

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
        unreadInviteCount.value = 0;
        refreshNotifications();
        Get.find<NotificationsController>().refreshNotifications();
      },
    );
  }

  //accept and reject

  Future<void> acceptInvite(int inviteId) async {
    acceptApiStatus[inviteId] = ApiStatus.loading;
    acceptException = null;

    final result = await _repo.acceptInvite(inviteId);

    result.fold(
      (exception) {
        acceptException = exception;
        acceptApiStatus[inviteId] = ApiStatusMapper.fromException(exception);
        showMessage("fail", ApiErrorHandler.getUserFriendlyMessage(exception),
            Colors.red, Colors.white);
      },
      (_) {
        acceptApiStatus[inviteId] = ApiStatus.success;
        refreshNotifications();
      },
    );
  }

  Future<void> reJectInvite(int inviteId) async {
    rejectApiStatus[inviteId] = ApiStatus.loading;
    rejectException = null;

    final result = await _repo.rejectInvite(inviteId);

    result.fold(
      (exception) {
        rejectException = exception;
        rejectApiStatus[inviteId] = ApiStatusMapper.fromException(exception);
        showMessage("fail", ApiErrorHandler.getUserFriendlyMessage(exception),
            Colors.red, Colors.white);
      },
      (_) {
        rejectApiStatus[inviteId] = ApiStatus.success;
        refreshNotifications();
      },
    );
  }
}
