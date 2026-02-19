import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/features/events/data/models/user_search_model.dart';
import 'package:eventsmanager/features/profileSettings/presentation/view/widgets/profile_image.dart';
import 'package:eventsmanager/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class UserCard extends StatelessWidget {
  final UserSearchModel user;
  final bool isSelected;
  final VoidCallback onPress;

  const UserCard({
    super.key,
    required this.isSelected,
    required this.user,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive breakpoints

    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.notification.withOpacity(0.2)
                  : AppColors.white.withOpacity(.5),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected
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
                    SizedBox(
                        height: 50.h,
                        width: 50.w,
                        child: ProfileImage(imageUrl: user.profileImageUrl)),
                    SizedBox(width: 12.w),

                    // Title and timestamp
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          CustomText(
                            text: user.name,
                            maxLines: 2,
                            textStyle: Get.textTheme.headlineSmall?.copyWith(
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            text: user.email,
                            textStyle: Get.textTheme.bodySmall?.copyWith(
                              fontSize: 16.sp,
                              height: 1.4,
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Body text
              ],
            ),
          ),
        ],
      ),
    );
  }
}
