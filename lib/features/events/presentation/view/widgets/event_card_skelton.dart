import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCardSkeleton extends StatelessWidget {
  const EventCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              height: 150.h,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 12.h),

          // Date
          Container(
            height: 14.h,
            width: 120.w,
            color: Colors.grey,
          ),

          SizedBox(height: 8.h),

          // Event name
          Container(
            height: 20.h,
            width: double.infinity,
            color: Colors.grey,
          ),

          SizedBox(height: 8.h),

          // Location row
          Row(
            children: [
              Container(
                width: 20.r,
                height: 20.r,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Container(
                  height: 14.h,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Bottom row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 14.h,
                width: 80.w,
                color: Colors.grey,
              ),
              Container(
                height: 30.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}