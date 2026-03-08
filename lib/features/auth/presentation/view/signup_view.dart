import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/features/auth/presentation/manager/signup/signup_controller.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/bottom_text_auth.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_icon_logo.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_body_auth.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupView extends GetView<SignUpControllerImp> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0.h),
          child: Form(
            key: controller.formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomeIconLogo(
                    boxColor: AppColors.primary,
                    iconColor: AppColors.white,
                    icon: Icons.calendar_today_rounded),
                SizedBox(
                  height: 10.h,
                ),
                //title
                CustomeTextTitleAuth(
                    content: "Get Started", alignment: TextAlign.center),

                //body
                CustomeTextBodyAuth(
                    content:
                        "Create an account to discover\n and manage events",
                    alignment: TextAlign.center),

                CustomeTextFormField(
                  labelText: "Full Name",
                  controller: controller.username,
                  hintText: "Enter your name",
                  iconData: Icons.person,
                  valid: (val) => AppValidator.validate(
                      value: val!,
                      type: ValidationType.fullname,
                      min: 2,
                      max: 100),
                  action: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  autofillHints: const [AutofillHints.name],
                ),

                CustomeTextFormField(
                  labelText: "Email address",
                  controller: controller.email,
                  hintText: "name@example.com",
                  iconData: Icons.email,
                  valid: (val) => AppValidator.validate(
                      value: val!, type: ValidationType.email),
                  action: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                ),

                GetBuilder<SignUpControllerImp>(
                  builder: (controller) => CustomeTextFormField(
                    labelText: "Password",
                    controller: controller.password,
                    obsecure: controller.isShow,
                    hintText: "Enter your password",
                    iconData: (controller.isShow)
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onIconTap: () => controller.showPassword(),
                    valid: (val) => AppValidator.validate(
                        value: val!,
                        type: ValidationType.password,
                        min: 8,
                        max: 30),
                    action: TextInputAction.next,
                    focusNode: controller.passwordFocus,
                    onFieldSubmitted: (p0) => controller.goToConfirmPassword(),
                  ),
                ),

                GetBuilder<SignUpControllerImp>(
                  builder: (controller) => CustomeTextFormField(
                    labelText: "Confirm Password",
                    controller: controller.confirmPassword,
                    obsecure: controller.isShowconfirm,
                    hintText: "Enter your password",
                    iconData: (controller.isShowconfirm)
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onIconTap: () => controller.showConfirmPassword(),
                    valid: (val) => AppValidator.validate(
                        value: val!,
                        type: ValidationType.confirmPassword,
                        matchWith: controller.password.text,
                        min: 8,
                        max: 30),
                    action: TextInputAction.done,
                    focusNode: controller.confirmPasswordFocus,
                  ),
                ),

                SizedBox(height: 12.h),
                CustomButton(
                    buttonColor: AppColors.primary,
                    content: "Register",
                    onTap: () {
                      controller.signUp();
                    }),

                Padding(
                  padding: EdgeInsets.only(bottom: 24.0.h),
                  child: BottomTextAuth(
                    text1: "Already  have an account? ",
                    text2: "Login",
                    onTap: () {
                      controller.goToLogIn();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
