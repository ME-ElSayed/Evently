import 'package:eventsmanager/features/events/presentation/manager/eventInvites/event_invites_controller.dart';
import 'package:get/get.dart';

class EventInvitesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EventInvitesController());
  }
}
