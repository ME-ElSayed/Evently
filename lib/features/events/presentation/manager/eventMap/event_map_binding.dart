import 'package:eventsmanager/features/events/presentation/manager/eventMap/event_map_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class EventMapBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<EventMapController>(EventMapController());
  }

}