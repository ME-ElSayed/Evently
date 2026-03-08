import 'package:eventsmanager/core/api/api_error_handler.dart';
import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/services/fcm_service.dart';
import 'package:eventsmanager/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToCheckEmail();
}

class LoginControllerImp extends LoginController {
  //form
  late TextEditingController email;
  late TextEditingController password;
  final GlobalKey<FormState> loginFormState = GlobalKey<FormState>();
  bool isShow = true;
  //api
  late final AuthRepository authRepo;
  final apiStatus = ApiStatus.idle.obs;
  ApiException? lastException;
  ApiException? resendException; // For resend errors

  showPassword() {
    isShow = (isShow) ? false : true;
    update();
  }

  @override
  goToSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }

  @override
  Future<void> login() async {
    if (!loginFormState.currentState!.validate()) return;
    apiStatus.value = ApiStatus.loading;
    lastException = null;

    final result = await authRepo.login(
      email: email.text.trim(),
      password: password.text,
    );

    result.fold(
      (exception) {
        //  All other errors
        lastException = exception;
        // edge case user not verfied and try login
        if (lastException!.code == "UNVERIFIED_USER") {
          resendVerificationCode();
          Get.offNamed(AppRoutes.signupveifycode,
              arguments: {"email": email.text.trim()});
        } else {
          apiStatus.value = ApiStatusMapper.fromException(exception);
        }
      },
      (_) {
        // Login success (verified user)
        apiStatus.value = ApiStatus.success;
        Get.find<FcmService>().syncTokenIfNeeded();
        Get.offAllNamed(AppRoutes.root);
      },
    );
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    authRepo = Get.find<AuthRepository>();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  @override
  goToCheckEmail() {
    Get.toNamed(AppRoutes.checkemail);
  }

  Future<void> resendVerificationCode() async {
    resendException = null;

    final result =
        await authRepo.resendVerificationOtp(email: email.text.trim());

    result.fold(
      (exception) {
        resendException = exception;
        // Show error in snackbar (doesn't interfere with verify dialog)
        showMessage(
          "Resend Failed",
          ApiErrorHandler.getUserFriendlyMessage(exception),
          Colors.red,
          Colors.black,
        );
      },
      (_) {
        showMessage(
          "Code Sent",
          'A  verification code has been sent to your email',
          Colors.green,
          Colors.black,
        );
      },
    );
  }
}
