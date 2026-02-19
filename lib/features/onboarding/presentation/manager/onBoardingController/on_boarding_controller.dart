import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';
import 'package:eventsmanager/features/onboarding/data/model/on_boarding_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OnBoardingController extends GetxController {
  next() {}
  onPageChanged(int index) {}
}

class OnBoardingControllerImp extends OnBoardingController {
  late PageController pagecontroller;
  int currentPage = 0;
  SharedprefService myService = Get.find();
  @override
  void onPageChanged(int index) {
    currentPage = index;
    update();
  }

  @override
  next() async{
    currentPage++;
    if (currentPage > onBoardingList.length - 1) {
    await  myService.stringSetter(key: "step", value: "1");
      Get.offAllNamed(AppRoutes.login);
    }
    pagecontroller.animateToPage(currentPage,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  void onInit() {
    pagecontroller = PageController();
    super.onInit();
  }
}
