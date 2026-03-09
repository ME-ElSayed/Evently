import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/functions/has_permission.dart';
import 'package:eventsmanager/features/events/data/models/event_manager_model.dart';
import 'package:eventsmanager/features/events/data/models/event_permission.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventManagers/event_managers_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_badge.dart';
import 'package:eventsmanager/features/profileSettings/presentation/view/widgets/profile_image.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ManagersCard extends StatelessWidget {
  final EventManagerModel manager;
  final List<EventPermission> permissions;
  const ManagersCard({super.key, required this.manager, required this.permissions});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 5.w : 8.w,
            vertical: isSmallScreen ? 5.h : 8.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.black,
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
              SizedBox(
                height: 30.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: ProfileImage(imageUrl: manager.profileImageUrl)),
                  SizedBox(width: isSmallScreen ? 12.w : 16.w),

                  // Title and timestamp
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        CustomText(
                          text: manager.name,
                          maxLines: 2,
                          textStyle: Get.textTheme.headlineSmall?.copyWith(
                            fontSize: isSmallScreen ? 18.sp : 20.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        // email
                        CustomText(
                          text: manager.email,
                          textStyle: TextStyle(
                            fontSize: isSmallScreen ? 16.sp : 18.sp,
                            color: AppColors.black,
                          ),
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        (hasPermission(permissions,EventPermission.removeManagers ))?
                        GetX<EventManagersController>(
                          builder: (controller) => CustomButton(
                            width: 100.w,
                            height: 40.h,
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white),
                            onTap: () => controller.removeManager(manager.id),
                            content: "Remove",
                            buttonColor: Colors.red,
                            loading: controller.removeApiStatus[manager.id],
                            noPadding: true,
                          ),
                        ):SizedBox.shrink()
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Unread indicator
        Positioned(
            top: 10.h,
            right: 10.w,
            child: EventBadge(label: "Manager", color: Colors.green)),
      ],
    );
  }
}
