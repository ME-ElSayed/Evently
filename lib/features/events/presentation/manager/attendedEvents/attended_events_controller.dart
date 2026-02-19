import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/api/api_status.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/features/events/presentation/manager/createdEvents/pagination_controller.dart';
import 'package:get/get.dart';

class AttendedEventsController extends PaginationController<EventModel> {
    final EventRepository _eventRepository = Get.find<EventRepository>();

  final apiStatus = ApiStatus.idle.obs;
  ApiException? lastException;

  AttendedEventsController() : super(limit: 10);

  @override
  Future<List<EventModel>> fetchPage(int page, int limit) async {
    apiStatus.value = ApiStatus.loading;
    lastException = null;

    final result = await _eventRepository.getAttendedEvents(
      page: page,
      limit: limit,
    );

    return result.fold(
      (exception) {
        lastException = exception;
        apiStatus.value = ApiStatusMapper.fromException(exception);
        hasMore.value = false;
        return <EventModel>[];
      },
      (events) {
        apiStatus.value = ApiStatus.success;
        return events;
      },
    );
  }

  Future<void> refreshEvents() => fetchInitial();
}