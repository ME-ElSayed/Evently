import 'package:eventsmanager/features/events/presentation/manager/sendInvite/send_invite_controller.dart';
import 'package:get/instance_manager.dart';

class SendInviteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SendInviteController());
  }
}
