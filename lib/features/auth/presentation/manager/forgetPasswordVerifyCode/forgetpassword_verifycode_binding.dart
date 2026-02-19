
import 'package:eventsmanager/features/auth/presentation/manager/forgetPasswordVerifyCode/forget_password_verifycode_controller.dart';
import 'package:get/get.dart';

class ForgetPasswordVerifyCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgetPasswordVerifyCodeControllerImp());
  }
}
