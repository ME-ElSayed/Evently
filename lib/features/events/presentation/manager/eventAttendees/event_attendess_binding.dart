import 'package:eventsmanager/features/events/presentation/manager/eventAttendees/event_attendess_controller.dart';
import 'package:get/get.dart';

class EventAttendessBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EventAttendeesController());
  }
}
