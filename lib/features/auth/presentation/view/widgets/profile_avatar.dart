import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatelessWidget {
  final bool isLoading;
  final Image image;
  final IconData? icon;
  final void Function()? onPressed;
  final void Function()? onRemove;

  const ProfileAvatar({
    super.key,
    required this.image,
    this.icon,
    this.onPressed,
    required this.isLoading,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Avatar
        CircleAvatar(
          radius: 60.r,
          backgroundColor: AppColors.darkwhite,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.r),
            child: image,
          ),
        ),

        /// Camera button
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            //splashColor: Colors.transparent,
            onTap: onPressed,
            child: (icon == null)
                ? SizedBox.shrink()
                : Container(
                    padding: EdgeInsets.all(9.r),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.w,
                            ),
                          )
                        : Icon(icon, color: Colors.white, size: 24.sp),
                  ),
          ),
        ),

        /// Remove button (only if onRemove provided)
        if (onRemove != null && !isLoading)
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: onRemove,
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, size: 14.sp, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
