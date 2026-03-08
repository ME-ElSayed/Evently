import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/constants/app_image_asset.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';

class ResetPasswordSuccessfulView extends StatelessWidget {
  const ResetPasswordSuccessfulView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Reset Password Successfully ",
              style: Get.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            Lottie.asset(AppImageAsset.success, width: 220.w, height: 220.h),
            SizedBox(height: 20.h),
            CustomButton(
              content: "Done",
              buttonColor: AppColors.primary,
              onTap: () => Get.offAllNamed(AppRoutes.login),
            )
          ],
        ),
      ),
    );
  }
}
