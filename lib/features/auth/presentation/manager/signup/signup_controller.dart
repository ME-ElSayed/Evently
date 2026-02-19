import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/extensions/form_auth_scroll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToLogIn();
}

class SignUpControllerImp extends SignUpController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  late FocusNode passwordFocus;
  late FocusNode confirmPasswordFocus;
  bool isShow = true;
  bool isShowconfirm = true;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  showPassword() {
    isShow = (isShow) ? false : true;
    update();
  }

  showConfirmPassword() {
    isShowconfirm = (isShowconfirm) ? false : true;
    update();
  }

  @override
  goToLogIn() {
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  signUp() {
    if (formState.validateAndScroll()) {
      Get.toNamed(AppRoutes.completeProfile, arguments: {
        "name": username.text.trim(),
        "password": password.text.trim(),
        "email": email.text.trim(),
      });
    }
  }

  void goToConfirmPassword() {
    confirmPasswordFocus.requestFocus();
  }

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    password.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }
}
