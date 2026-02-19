import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/features/onboarding/data/model/on_boarding_info.dart';
import 'package:eventsmanager/features/onboarding/presentation/manager/onBoardingController/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                  onBoardingList.length,
                  (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        width: (controller.currentPage == index) ? 40.w : 10.w,
                        height: 10.h,
                        margin: EdgeInsets.only(right: 6.w),
                        decoration: BoxDecoration(
                          color: (controller.currentPage == index)
                              ? AppColors.primary
                              : AppColors.darkwhite,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ))
            ],
          ),
        );
      },
    );
  }
}
