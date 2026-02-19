import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventDetails/event_details_controller.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventAttendance extends StatelessWidget {
  const EventAttendance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetX<EventDetailsController>(
        init: EventDetailsController(),
        builder: (controller) => CustomButton(
              content: "Attend",
              buttonColor: AppColors.primary,
              loading: controller.attendApiStatus.value,
              onTap: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (_) => Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Icon(
                        Icons.event_available,
                        size: 48.sp,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 16.h),
                      Text('Confirm Attendance',
                          style: Get.textTheme.headlineMedium),
                      SizedBox(height: 8.h),
                      Text(
                        'You will receive a QR code to enter the event.',
                        style: Get.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      CustomButton(
                        buttonColor: AppColors.primary,
                        content: 'Confirm',
                        onTap: () {
                          //controller.event.isAttended = true;
                          controller.attendEvent();

                          Get.back();
                        },
                      ),
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Cancel',
                          style: Get.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
