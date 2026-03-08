import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/features/auth/presentation/manager/forgetPasswordVerifyCode/forget_password_verifycode_controller.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/verification_pin.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/verification_timer.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_icon_logo.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_body_auth.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordVerifiyCodeView
    extends GetView<ForgetPasswordVerifyCodeControllerImp> {
  const ForgetPasswordVerifiyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Obx(
          () => ApiErrorHandlingView(
            status: controller.apiStatusVerify.value,
            exception: controller.verifyException,
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: Column(
                    children: [
                      CustomeIconLogo(
                          boxColor: AppColors.primary,
                          iconColor: AppColors.white,
                          icon: Icons.lock_open),
                      SizedBox(height: 32.h),
                      CustomeTextTitleAuth(
                        content: "Verification Code",
                        alignment: TextAlign.center,
                      ),
                      CustomeTextBodyAuth(
                        content: "we sent a code to your email",
                        alignment: TextAlign.center,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: VerificationPin(
                          controller: controller.pinController,
                          onChanged: (value) {
                            controller.verificationCodeFilled.value =
                                value.length == 6;
                          },
                          onComplete: (value) {
                            controller.verificationCodeFilled.value = true;
                            controller.verificationCode = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                       Obx(() {
                        return VerificationTimer(
                          isLoading: controller.apiStatusResend.value,
                          secondsLeft: controller.secondsLeft.value,
                          canResend: controller.canResend.value,
                          onTap: () {
                            controller.resendVerificationCode();
                          },
                        );
                      }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Obx(
                        () => CustomButton(
                          loading: controller.apiStatusVerify.value,
                          buttonColor: (controller.verificationCodeFilled.value)
                              ? AppColors.primary
                              : Colors.grey[300]!,
                          content: "Verifiy",
                          onTap: () {
                            if (controller.verificationCodeFilled.value) {
                              controller.verifyCode();
                            } else {
                              showMessage("message", "enter full otp",
                                  Colors.red, Colors.black);
                            }
                          },
                        ),
                      )
                    ],
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
