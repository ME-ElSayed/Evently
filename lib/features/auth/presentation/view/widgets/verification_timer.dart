import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/core/services/api/api_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationTimer extends StatelessWidget {
  final int secondsLeft;
  final bool canResend;
  final void Function()? onTap;
  final ApiStatus? isLoading;
  const VerificationTimer(
      {super.key,
      required this.secondsLeft,
      required this.canResend,
      this.onTap,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: canResend
              ? AppColors.primary.withOpacity(0.1)
              : Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: (isLoading == ApiStatus.loading)
            ? CircularProgressIndicator(
                color: AppColors.white,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.timer, size: 18.r),
                  SizedBox(width: 6.w),
                  Text(
                    canResend
                        ? "Resend code"
                        : "Resend code in 00:${secondsLeft.toString().padLeft(2, '0')}",
                    selectionColor: AppColors.primary,
                    style: TextStyle(
                      color: canResend ? AppColors.primary : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
