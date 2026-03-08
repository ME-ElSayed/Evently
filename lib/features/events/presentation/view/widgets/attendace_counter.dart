import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class AttendanceCounter extends StatelessWidget {
  final int current;
  final int total;

  const AttendanceCounter(
      {super.key, required this.current, required this.total});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Attendance",
          style: Get.textTheme.headlineMedium!.copyWith(fontSize: 20.sp),
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(3.r),
          child: StepProgressIndicator(
            totalSteps: total,
            currentStep: current,
            selectedColor: AppColors.primary,
            unselectedColor: AppColors.darkwhite,
            padding: 0,
            size: 6.r,
          ),
        ),
        SizedBox(height: 8.h),
        Text("$current / $total joined", style: Get.textTheme.bodySmall),
      ],
    );
  }
}
