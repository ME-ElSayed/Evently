import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class VerificationPin extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(String)? onComplete;
  const VerificationPin({
    super.key,
    this.onChanged,
    this.onComplete, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      length: 6,
      autofocus: false,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 22.w,
            height: 2.h,
            color: Colors.black,
          ),
        ],
      ),
      defaultPinTheme: PinTheme(
        width: 50.w,
        height: 50.w,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.primary),
        ),
      ),
      onChanged: onChanged,
      onCompleted: onComplete,
    );
  }
}
