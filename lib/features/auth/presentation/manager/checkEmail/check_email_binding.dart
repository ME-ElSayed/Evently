
import 'package:eventsmanager/features/auth/presentation/manager/checkEmail/check_email_controller.dart';
import 'package:get/get.dart';

class CheckEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckEmailControllerImp());
  }
}
