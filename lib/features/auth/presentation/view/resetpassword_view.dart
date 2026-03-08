import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/features/auth/presentation/manager/resetPassword/resetpassword_controller.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_body_auth.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_title_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPasswordView extends GetView<ResetpasswordControllerImp> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Obx(
          () => ApiErrorHandlingView(
            status: controller.apiStatus.value,
            exception: controller.lastException,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: controller.formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomeTextTitleAuth(
                      content: "Reset Password",
                      alignment: TextAlign.center,
                    ),
                    CustomeTextBodyAuth(
                      content:
                          "Your new password must be different\n from previously used passwords",
                      alignment: TextAlign.center,
                    ),
                    GetBuilder<ResetpasswordControllerImp>(
                      builder: (controller) => CustomeTextFormField(
                        hintText: " Enter new password",
                        labelText: "New Password",
                        iconData: (controller.isShowPassword)
                            ? Icons.visibility_off
                            : Icons.visibility,
                        controller: controller.password,
                        obsecure: controller.isShowPassword,
                        onIconTap: () => controller.showPassword(),
                        valid: (val) {
                          return AppValidator.validate(
                              value: val!,
                              type: ValidationType.password,
                              min: 8,
                              max: 30);
                        },
                      ),
                    ),
                    GetBuilder<ResetpasswordControllerImp>(
                      builder: (controller) => CustomeTextFormField(
                        hintText: "Re_enter password",
                        labelText: "Confirm Password",
                        iconData: (controller.isShowConfirmPassword)
                            ? Icons.visibility_off
                            : Icons.visibility,
                        controller: controller.confirmPassword,
                        obsecure: controller.isShowConfirmPassword,
                        onIconTap: () => controller.showConfirmPassword(),
                        valid: (val) {
                          return AppValidator.validate(
                              value: val!,
                              type: ValidationType.confirmPassword,
                              matchWith: controller.password.text,
                              min: 8,
                              max: 30);
                        },
                      ),
                    ),
                    CustomButton(
                      buttonColor: AppColors.primary,
                      loading: controller.apiStatus.value,
                      content: "save",
                      onTap: () {
                        controller.resetPassword();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
