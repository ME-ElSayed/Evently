
import 'package:eventsmanager/features/auth/presentation/manager/signup/signup_controller.dart';
import 'package:get/get.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpControllerImp());
  }
}
