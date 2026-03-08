import 'package:eventsmanager/core/api/api_error_handler.dart';
import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';
import 'package:eventsmanager/features/events/data/models/event_invite_model.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/features/events/presentation/manager/createdEvents/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventInvitesController extends PaginationController<EventInviteModel> {
  final EventRepository _eventRepository = Get.find<EventRepository>();
  final SharedprefService pref = Get.find<SharedprefService>();
  late EventModel event;
  int? userId;
  final fetchApiStatus = ApiStatus.idle.obs;
  ApiException? fetchException;
  RxMap<int, ApiStatus> resendStatus = <int, ApiStatus>{}.obs;
  ApiException? resendException;

  final isRemoving = false.obs;

  EventInvitesController() : super(limit: 10);

  @override
  void onInit() {
    event = Get.arguments["eventModel"];
    userId = pref.getUserId();
    super.onInit();
  }

  @override
  Future<List<EventInviteModel>> fetchPage(int page, int limit) async {
    fetchApiStatus.value = ApiStatus.loading;
    fetchException = null;

    final result = await _eventRepository.getEventInvites(
      eventId: event.id,
      page: page,
      limit: limit,
    );

    return result.fold(
      (exception) {
        fetchException = exception;
        fetchApiStatus.value = ApiStatusMapper.fromException(exception);
        hasMore.value = false;
        return <EventInviteModel>[];
      },
      (invites) {
        fetchApiStatus.value = ApiStatus.success;
        return invites;
      },
    );
  }

  Future<void> resenInvite(int inviteId) async {
    resendStatus[inviteId] = ApiStatus.loading;
    resendException = null;

    final result = await _eventRepository.resendInvite(
        inviteId: inviteId, eventId: event.id);

    result.fold(
      (exception) {
        resendException = exception;
        resendStatus[inviteId] = ApiStatusMapper.fromException(exception);
        showMessage("fail", ApiErrorHandler.getUserFriendlyMessage(exception),
            Colors.red, Colors.white);
      },
      (_) {
        resendStatus[inviteId] = ApiStatus.success;
        fetchInitial();
      },
    );
  }

  Future<void> refreshInvites() => fetchInitial();
}
