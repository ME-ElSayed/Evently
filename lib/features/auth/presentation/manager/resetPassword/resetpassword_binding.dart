import 'package:eventsmanager/features/auth/presentation/manager/resetPassword/resetpassword_controller.dart';
import 'package:get/get.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetpasswordControllerImp());
  }
}
