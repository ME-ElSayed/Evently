
import 'package:eventsmanager/features/auth/presentation/manager/signupVerifyCode/signup_verify_code_controller.dart';
import 'package:get/get.dart';

class SignupVerifyCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupVerifyCodeControllerImp());
  }
}
