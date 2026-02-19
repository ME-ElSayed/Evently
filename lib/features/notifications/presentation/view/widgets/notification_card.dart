import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/core/functions/format_time_stamp.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/features/notifications/data/models/notification_model.dart';
import 'package:eventsmanager/features/notifications/presentation/view/widgets/notification_icon.dart';
import 'package:eventsmanager/features/notifications/presentation/view/widgets/swipe_notification.dart';
import 'package:eventsmanager/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive breakpoints
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return SwipeNotification(
      id: notification.id,
      child: GestureDetector(
        onTap: () {
          (notification.targetType == "EVENT")
              ? Get.toNamed(AppRoutes.eventDetails,
                  arguments: {'eventId': notification.targetId})
              : null;
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 10.w : 12.w,
                vertical: isSmallScreen ? 10.h : 12.h,
              ),
              decoration: BoxDecoration(
                color: !notification.read
                    ? AppColors.notification.withOpacity(0.2)
                    : AppColors.white.withOpacity(.5),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: !notification.read
                      ? AppColors.notification.withOpacity(0.3)
                      : AppColors.black,
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
                      NotificationIcon(type: notification.type),
                      SizedBox(width: isSmallScreen ? 12.w : 16.w),

                      // Title and timestamp
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            CustomText(
                              text: notification.data.title,
                              maxLines: 2,
                              textStyle: Get.textTheme.headlineSmall?.copyWith(
                                fontSize: isSmallScreen ? 18.sp : 20.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            // Timestamp
                            CustomText(
                              text: formatTimestamp(notification.createdAt),
                              textStyle: TextStyle(
                                fontSize: isSmallScreen ? 16.sp : 18.sp,
                                color: notification.read
                                    ? AppColors.notification
                                    : AppColors.black.withOpacity(0.6),
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),

                      // Reserved space for unread indicator
                      SizedBox(width: notification.read ? 20.w : 0),
                    ],
                  ),

                  // Body text
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(left: isSmallScreen ? 44.w : 56.w),
                    child: CustomText(
                      text: notification.data.body,
                      textStyle: Get.textTheme.bodySmall?.copyWith(
                        fontSize: isSmallScreen ? 16.sp : 18.sp,
                        height: 1.4,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),

            // Unread indicator
            if (!notification.read)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: AppColors.notification,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.notification.withOpacity(0.6),
                        blurRadius: 8.r,
                        spreadRadius: 1.r,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
