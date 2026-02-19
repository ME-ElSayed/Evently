import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/features/auth/presentation/manager/login/login_controller.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/bottom_text_auth.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_icon_logo.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_body_auth.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginControllerImp> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => ApiErrorHandlingView(
            status: controller.apiStatus.value,
            exception: controller.lastException,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: controller.loginFormState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    // Icon Placeholder
                    CustomeIconLogo(
                        boxColor: AppColors.primary,
                        iconColor: AppColors.white,
                        icon: Icons.calendar_today_rounded),
                    SizedBox(height: 32.h),
                    //title
                    CustomeTextTitleAuth(
                        content: "Let's get started",
                        alignment: TextAlign.center),

                    //body
                    CustomeTextBodyAuth(
                        content:
                            "Sign in to manage your events,\n tickets, and bookings effortlessly.",
                        alignment: TextAlign.center),

                    CustomeTextFormField(
                      labelText: "Email Address",
                      controller: controller.email,
                      hintText: "name@example.com",
                      iconData: Icons.email,
                      valid: (val) => AppValidator.validate(
                          value: val!, type: ValidationType.email),
                      action: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                    ),

                    GetBuilder<LoginControllerImp>(
                      builder: (controller) => CustomeTextFormField(
                        labelText: "Password",
                        controller: controller.password,
                        action: TextInputAction.done,
                        valid: (val) => AppValidator.validate(
                            value: val!,
                            type: ValidationType.password,
                            min: 8,
                            max: 30),
                        obsecure: controller.isShow,
                        hintText: "Enter your password",
                        iconData: (controller.isShow)
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onIconTap: () => controller.showPassword(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            controller.goToCheckEmail();
                          },
                          style: TextButton.styleFrom(
                            overlayColor: Colors.transparent,
                            padding: EdgeInsets.only(bottom: 15.h),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: Size(0, 0),
                          ),
                          child: Text(
                            "forgotPassword?",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: AppColors.primary),
                          )),
                    ),
                    SizedBox(height: 12.h),
                    CustomButton(
                        buttonColor: AppColors.primary,
                        loading: controller.apiStatus.value,
                        content: "Continue",
                        onTap: () {
                          controller.login();
                        }),

                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0.h),
                      child: BottomTextAuth(
                        text1: "Don't have an account? ",
                        text2: "Register",
                        onTap: () {
                          // to do
                          controller.goToSignUp();
                        },
                      ),
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
