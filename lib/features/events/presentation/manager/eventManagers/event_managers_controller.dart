import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/core/services/api/api_error_handler.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/api/api_status.dart';
import 'package:eventsmanager/features/events/data/models/event_manager_model.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/features/events/presentation/manager/createdEvents/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventManagersController extends PaginationController<EventManagerModel> {
  final EventRepository _eventRepository = Get.find<EventRepository>();
  late EventModel event;
  late int eventId;

  final fetchApiStatus = ApiStatus.idle.obs;
  ApiException? fetchException;
 RxMap<int, ApiStatus> removeApiStatus = <int, ApiStatus>{}.obs;
  ApiException? removeException;

  EventManagersController() : super(limit: 10);

  @override
  void onInit() {
    event = Get.arguments["eventModel"];
    eventId = event.id;
    super.onInit();
  }

  @override
  Future<List<EventManagerModel>> fetchPage(int page, int limit) async {
    fetchApiStatus.value = ApiStatus.loading;
    fetchException = null;

    final result = await _eventRepository.getEventManagers(
      eventId: eventId,
      page: page,
      limit: limit,
    );

    return result.fold(
      (exception) {
        fetchException = exception;
        fetchApiStatus.value = ApiStatusMapper.fromException(exception);
        hasMore.value = false;
        return <EventManagerModel>[];
      },
      (managers) {
        fetchApiStatus.value = ApiStatus.success;
        return managers;
      },
    );
  }

  Future<void> refreshMangers() => fetchInitial();

  Future<void> removeManager(int managerId) async {
    removeApiStatus[managerId] = ApiStatus.loading;
    removeException = null;

    final result = await _eventRepository.removeManager(
        eventId: eventId, managerId: managerId);

    result.fold(
      (exception) {
        removeException = exception;
        removeApiStatus[managerId] = ApiStatusMapper.fromException(exception);
        showMessage("fail", ApiErrorHandler.getUserFriendlyMessage(exception),
            Colors.red, Colors.white);
      },
      (_) {
        removeApiStatus[managerId] = ApiStatus.success;
        fetchInitial();
      },
    );
  }
}
