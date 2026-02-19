import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextAboveField extends StatelessWidget {
  final AlignmentGeometry alignment;
  // ignore: non_constant_identifier_names
  final String content;
  const TextAboveField(
      {super.key, required this.alignment, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Align(
        alignment: alignment,
        child: Text(
          content,
          style: Get.textTheme.bodySmall!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp),
        ),
      ),
    );
  }
}
