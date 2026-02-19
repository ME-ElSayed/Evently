import 'package:eventsmanager/features/onboarding/data/model/on_boarding_info.dart';
import 'package:eventsmanager/features/onboarding/presentation/manager/onBoardingController/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: onBoardingList.length,
      controller: controller.pagecontroller,
      onPageChanged: controller.onPageChanged,
      itemBuilder: (context, i) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth =
                constraints.maxWidth > 600 ? 540.0 : constraints.maxWidth;

            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 0.02.sh),

                        /// Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: Image.asset(
                            onBoardingList[i].image,
                            width: maxWidth,
                            height: maxWidth * 0.7,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(height: 30.h),

                        /// Title
                        Text(
                          onBoardingList[i].title,
                          style: Get.theme.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 12.h),

                        /// Body
                        Text(
                          onBoardingList[i].body,
                          style: Get.theme.textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
