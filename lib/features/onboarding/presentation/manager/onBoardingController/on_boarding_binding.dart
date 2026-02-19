import 'package:eventsmanager/features/onboarding/presentation/manager/onBoardingController/on_boarding_controller.dart';
import 'package:get/get.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingControllerImp>(() => OnBoardingControllerImp());
  }
}
