import 'dart:async';

import 'package:eventsmanager/core/api/api_error_handler.dart';
import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/services/fcm_service.dart';
import 'package:eventsmanager/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SignupVerifyCodeController extends GetxController {
  resendVerificationCode();
}

class SignupVerifyCodeControllerImp extends SignupVerifyCodeController {
  //data
  late String email;
  final TextEditingController pinController = TextEditingController();

  //verificationCode
  String verificationCode = "";
  RxBool verificationCodeFilled = false.obs;

  //timer
  Timer? _timer;
  final int resendTime = 60;
  RxInt secondsLeft = 60.obs;
  RxBool canResend = false.obs;

  //api - SEPARATE STATES
  late final AuthRepository authRepo;
  final apiStatusVerify = ApiStatus.idle.obs; // For verify operation
  final apiStatusResend = ApiStatus.idle.obs; // For resend operation
  ApiException? verifyException; // For verify errors
  ApiException? resendException; // For resend errors

  Future<void> verifyCode() async {
    apiStatusVerify.value = ApiStatus.loading;
    verifyException = null;

    final result = await authRepo.verifyUser(
      email: email,
      otpCode: verificationCode,
    );

    result.fold(
      (exception) {
        verifyException = exception;
        apiStatusVerify.value = ApiStatusMapper.fromException(exception);
        pinController.clear();
      },
      (_) {
        apiStatusVerify.value = ApiStatus.success;
         Get.find<FcmService>().syncTokenIfNeeded();
        Get.offAllNamed(AppRoutes.root);
      },
    );
  }

  @override
  Future<void> resendVerificationCode() async {
    // Block resend if timer is still running
    if (!canResend.value) return;

    apiStatusResend.value = ApiStatus.loading;
    resendException = null;

    final result = await authRepo.resendVerificationOtp(email: email);

    result.fold(
      (exception) {
        resendException = exception;
        apiStatusResend.value = ApiStatusMapper.fromException(exception);

        // Show error in snackbar (doesn't interfere with verify dialog)
        showMessage(
          "Resend Failed",
          ApiErrorHandler.getUserFriendlyMessage(exception),
          Colors.red,
          Colors.black,
        );
      },
      (_) {
        apiStatusResend.value = ApiStatus.success;
        startTimer();

        showMessage(
          "Code Sent",
          'A new verification code has been sent to your email',
          Colors.green,
          Colors.black,
        );
      },
    );
  }

  void startTimer() {
    canResend.value = false;
    secondsLeft.value = resendTime;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value == 0) {
        canResend.value = true;
        timer.cancel();
      } else {
        secondsLeft.value--;
      }
    });
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    authRepo = Get.find<AuthRepository>();
    startTimer();
  
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
