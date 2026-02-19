import 'package:eventsmanager/features/auth/presentation/manager/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginControllerImp(), permanent: false);
  }
}
