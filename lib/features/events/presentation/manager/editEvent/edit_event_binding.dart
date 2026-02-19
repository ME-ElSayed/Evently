import 'package:eventsmanager/features/events/presentation/manager/editEvent/edit_event_controller.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class EditEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditEventController());
  }
}
