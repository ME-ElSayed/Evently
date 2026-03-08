import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCardSkeleton extends StatelessWidget {
  const NotificationCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.only(bottom: 12.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.black.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 4.r,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon placeholder
              Container(
                width: 40.r,
                height: 40.r,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 16.w),

              // Title and timestamp
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title placeholder
                    Container(
                      height: 18.h,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8.h),
                    // Timestamp placeholder
                    Container(
                      height: 14.h,
                      width: 100.w,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Body text placeholder
          Padding(
            padding: EdgeInsets.only(left: 56.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14.h,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 14.h,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 14.h,
                  width: 200.w,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}