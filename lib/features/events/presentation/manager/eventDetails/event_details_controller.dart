import 'package:eventsmanager/core/api/api_error_handler.dart';
import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/features/notifications/data/models/invite_notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailsController extends GetxController {
  final EventRepository _eventRepository = Get.find<EventRepository>();
  //invite
  final invite = Rxn<InviteNotificationModel>();
  late final bool _isInviteView;
  bool get isInviteView => invite.value != null;

  // API state
  final detailsApiStatus = ApiStatus.idle.obs;
  ApiException? detailsException;
  final attendApiStatus = ApiStatus.idle.obs;
  ApiException? attendException;

  // UI state
  final showFullDescription = false.obs;
  final isAttended = false.obs;
  final event = Rxn<EventModel>();

  late final int _eventId;

  @override
  void onInit() {
    super.onInit();
    _initializeFromArguments();

    if (!_isInviteView) {
      fetchEventDetails();
    } else {
      detailsApiStatus.value = ApiStatus.success;
    }
  }

  void _initializeFromArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null)
      throw ArgumentError('EventDetailsController requires arguments');

    invite.value = args['invite'] as InviteNotificationModel?;
    _isInviteView = invite.value != null;

    if (args['eventId'] != null) {
      _eventId = args['eventId'] as int;
      return;
    }

    final eventModel = args['eventModel'] as EventModel?;
    if (eventModel == null) {
      throw ArgumentError('Either eventId or eventModel must be provided');
    }

    _eventId = eventModel.id;
    event.value = eventModel;
    isAttended.value = eventModel.attended ?? false;
  }

  /* ================= API ================= */

  Future<void> fetchEventDetails() async {
    detailsApiStatus.value = ApiStatus.loading;
    detailsException = null;

    final result = await _eventRepository.getEventDetails(_eventId);

    result.fold(
      (exception) {
        detailsException = exception;
        detailsApiStatus.value = ApiStatusMapper.fromException(exception);
      },
      (fullEvent) {
        event.value = fullEvent;
        // event.value != null ? event.value!.merge(fullEvent) : fullEvent;
        isAttended.value = event.value?.attended ?? false;
        detailsApiStatus.value = ApiStatus.success;
      },
    );
  }

  /* ================= ACTIONS ================= */

  Future<void> attendEvent() async {
    if (event.value == null) return;
    attendApiStatus.value = ApiStatus.loading;
    attendException = null;

    final result = await _eventRepository.attendEvent(event.value!.id);

    result.fold(
      (exception) {
        attendException = exception;
        attendApiStatus.value = ApiStatusMapper.fromException(exception);

        showMessage(
          "Failed",
          ApiErrorHandler.getUserFriendlyMessage(exception),
          Colors.red,
          Colors.black,
        );
      },
      (_) {
        attendApiStatus.value = ApiStatus.success;

        showMessage(
          "Success",
          'You registered successfully',
          Colors.green,
          Colors.black,
        );
      },
    );
  }

  void toggleDescription() {
    showFullDescription.toggle();
  }

  Future<void> retry() => fetchEventDetails();
}
