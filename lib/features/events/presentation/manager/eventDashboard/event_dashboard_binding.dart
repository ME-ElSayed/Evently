import 'package:eventsmanager/features/events/presentation/manager/eventDashboard/event_dashboard_controller.dart';
import 'package:get/get.dart';

class EventDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EventDashboardController());
  }
}
