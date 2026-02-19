import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/core/services/api/api_error_handler.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/api/api_status.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/features/events/presentation/manager/createdEvents/created_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class EventDashboardController extends GetxController {
  final EventRepository _eventRepository = Get.find<EventRepository>();
  late EventModel event;
  final leaveApiStatus = ApiStatus.idle.obs;
  ApiException? leaveException;

  @override
  void onInit() {
    event = Get.arguments["eventModel"];
    super.onInit();
  }

  Future<void> leaveEvent() async {
    leaveApiStatus.value = ApiStatus.loading;
    leaveException = null;

    final result = await _eventRepository.leaveEvent(eventId: event.id);

    result.fold(
      (exception) {
        leaveException = exception;
        leaveApiStatus.value = ApiStatusMapper.fromException(exception);
        showMessage("fail", ApiErrorHandler.getUserFriendlyMessage(exception),
            Colors.red, Colors.white);
      },
      (_) {
        leaveApiStatus.value = ApiStatus.success;
        if (Get.isRegistered<CreatedEventController>()) {
          Get.find<CreatedEventController>().refreshEvents();
        }
        Get.until((route) => route.isFirst);
        Get.find<PersistentTabController>().jumpToTab(3);
      },
    );
  }
}
