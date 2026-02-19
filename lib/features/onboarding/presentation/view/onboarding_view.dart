import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/features/onboarding/presentation/manager/onBoardingController/on_boarding_controller.dart';
import 'package:eventsmanager/features/onboarding/presentation/view/widgets/custom_slider.dart';
import 'package:eventsmanager/features/onboarding/presentation/view/widgets/dot_controller.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardingView extends GetView<OnBoardingControllerImp> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onBoardingBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: CustomSliderOnBoarding(),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CustomDotControllerOnBoarding(),
                    Spacer(
                      flex: 2,
                    ),
                    CustomButton(
                      content: "Next",
                      width: 0.6.sw,
                      buttonColor: AppColors.primary,
                      onTap: () => controller.next(),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
