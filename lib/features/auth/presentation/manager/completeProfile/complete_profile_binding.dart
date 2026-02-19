
import 'package:eventsmanager/features/auth/presentation/manager/completeProfile/complete_profile_controller.dart';
import 'package:get/get.dart';

class CompleteProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CompleteProfileControllerImp());
  }
}
