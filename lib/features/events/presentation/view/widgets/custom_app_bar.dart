import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String content;

  const CustomAppBar({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final Color appBarColor = AppColors.statusprimary;

    return SliverToBoxAdapter(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Container(
          padding: EdgeInsets.only(top: statusBarHeight),
          decoration: BoxDecoration(
            color: appBarColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.r),
              bottomRight: Radius.circular(24.r),
            ),
          ),
          child: SizedBox(
            height: 56.h,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headlineMedium?.copyWith(
                    color: AppColors.background,
                    fontSize: 25.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
