import 'package:eventsmanager/features/events/presentation/manager/eventManagers/event_managers_controller.dart';
import 'package:get/get.dart';

class EventManagersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EventManagersController());
  }
}
