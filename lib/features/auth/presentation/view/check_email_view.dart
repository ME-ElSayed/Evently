import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/features/auth/presentation/manager/checkEmail/check_email_controller.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_icon_logo.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_body_auth.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckEmailView extends GetView<CheckEmailControllerImp> {
  const CheckEmailView({super.key});

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
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: Form(
                    key: controller.formState,
                    child: Column(
                      children: [
                        CustomeIconLogo(
                            boxColor: AppColors.primary,
                            iconColor: AppColors.white,
                            icon: Icons.email_rounded),
                        SizedBox(height: 32.h),
                        CustomeTextTitleAuth(
                          content: "Check Email",
                          alignment: TextAlign.center,
                        ),
                        CustomeTextBodyAuth(
                          content:
                              "Enter your email to receive an otp\n to create a new password.",
                          alignment: TextAlign.center,
                        ),
                        CustomeTextFormField(
                          hintText: "enter your email",
                          labelText: "Email",
                          controller: controller.email,
                          iconData: Icons.email_outlined,
                          valid: (val) {
                            return AppValidator.validate(
                                value: val!, type: ValidationType.email);
                          },
                        ),
                        Obx(
                          () => CustomButton(
                            buttonColor: AppColors.primary,
                            content: "check",
                            onTap: () => controller.goToVerifyCode(),
                            loading: controller.apiStatus.value,
                          ),
                        ),
                      ],
                    ),
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
