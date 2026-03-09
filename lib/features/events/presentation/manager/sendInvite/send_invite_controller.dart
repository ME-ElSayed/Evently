import 'dart:async';
import 'package:eventsmanager/core/api/api_error_handler.dart';
import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/models/event_permission.dart';
import 'package:eventsmanager/features/events/data/models/invite_role.dart';
import 'package:eventsmanager/features/events/data/models/user_search_model.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/features/events/presentation/manager/createdEvents/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendInviteController extends PaginationController<UserSearchModel> {
  final EventRepository _repository = Get.find<EventRepository>();
  final RxString searchQuery = ''.obs;
  SendInviteController() : super(limit: 10);
  late EventModel event;

  final TextEditingController searchControl = TextEditingController();
  final fetchApiStatus = ApiStatus.idle.obs;
  ApiException? fetchException;

  final sendApiStatus = ApiStatus.idle.obs;
  ApiException? sendException;
  
  final selectedRole = InviteRole.ATTENDEE.obs;
  final selectedPermissions = <EventPermission>[].obs;

  @override
  void onInit() {
    event = Get.arguments["eventModel"];
    super.onInit();
  }

  void onSearchSubmit(String query) {
    if (query.trim() == "") return;
    searchQuery.value = query.trim();
    fetchInitial();
  }

  @override
  Future<List<UserSearchModel>> fetchPage(int page, int limit) async {
    if (searchQuery.value.isEmpty) return [];
    fetchApiStatus.value = ApiStatus.loading;
    fetchException = null;

    final result = await _repository.searchUsers(
      query: searchQuery.value,
      page: page,
      limit: limit,
    );

    return result.fold(
      (exception) {
        fetchException = exception;
        fetchApiStatus.value = ApiStatusMapper.fromException(exception);
        hasMore.value = false;
        return <UserSearchModel>[];
      },
      (users) {
        fetchApiStatus.value = ApiStatus.success;
        return users;
      },
    );
  }

  final RxnInt selectedUserId = RxnInt();

  void selectUser(int userId) {
    selectedUserId.value = userId;

    selectedRole.value = InviteRole.ATTENDEE;
    selectedPermissions.clear();
  }

  bool isSelected(int userId) {
    return selectedUserId.value == userId;
  }

  

  void changeRole(InviteRole role) {
    selectedRole.value = role;

    if (role == InviteRole.ATTENDEE) {
      selectedPermissions.clear();
    }
  }

  void togglePermission(EventPermission permission) {
    if (selectedPermissions.contains(permission)) {
      selectedPermissions.remove(permission);
    } else {
      selectedPermissions.add(permission);
    }

    selectedPermissions.refresh();
  }

  Future<void> sendInvite() async {
    if (selectedUserId.value == null) return;

    sendApiStatus.value = ApiStatus.loading;
    sendException = null;
    final result = await _repository.sendInvite(
      eventId: event.id,
      userId: selectedUserId.value!,
      role: selectedRole.value.name,
      permissions: selectedRole.value == InviteRole.MANAGER
          ? selectedPermissions.map((e) => e.value).toList()
          : null,
    );

    result.fold(
      (exception) {
        sendException = exception;
        sendApiStatus.value = ApiStatusMapper.fromException(exception);

        showMessage("fail", ApiErrorHandler.getUserFriendlyMessage(exception),
            Colors.red, Colors.black);
      },
      (_) {
        sendApiStatus.value = ApiStatus.success;
        showMessage(
            "Success", "Invite has been sent", Colors.green, Colors.black);
      },
    );
  }

  @override
  void onClose() {
    searchControl.dispose();
    super.onClose();
  }

  Future<void> refreshInvites() => fetchInitial();
}
