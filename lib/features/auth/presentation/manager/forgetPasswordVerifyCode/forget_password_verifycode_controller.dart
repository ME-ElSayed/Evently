import 'dart:async';

import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ForgetPasswordVerifyCodeController extends GetxController {
  verifyCode();
  resendVerificationCode();
}

class ForgetPasswordVerifyCodeControllerImp
    extends ForgetPasswordVerifyCodeController {
  final TextEditingController pinController = TextEditingController();
  //api
  late final AuthRepository authRepo;
  final apiStatusVerify = ApiStatus.idle.obs; // For verify operation
  final apiStatusResend = ApiStatus.idle.obs; // For resend operation
  ApiException? verifyException; // For verify errors
  ApiException? resendException; // For resend errors
  late String email;

  Timer? _timer;
  final int resendTime = 60;
  String verificationCode = "";
  RxBool verificationCodeFilled = false.obs;

  RxInt secondsLeft = 60.obs;
  RxBool canResend = false.obs;

  @override
  Future<void> verifyCode() async {
    apiStatusVerify.value = ApiStatus.loading;
    verifyException = null;

    final result = await authRepo.verifyPasswordOtp(
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

        Get.offAllNamed(AppRoutes.restpassword, arguments: {"email": email});
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

  @override
  Future<void> resendVerificationCode() async {
    // Optional: block resend if timer is still running
    if (!canResend.value) return;

    apiStatusResend.value = ApiStatus.loading;
    resendException = null;

    try {
      await authRepo.forgotPassword(
        email: email, // stored from signup
      );

      // Success → reset state and restart timer
      apiStatusResend.value = ApiStatus.idle;
      startTimer();

      showMessage(
          "Code Sent",
          'A new verification code has been sent to your email',
          Colors.green,
          Colors.black);
    } catch (e) {
      // Repo should already convert this to ApiException
      resendException = e as ApiException?;
      apiStatusResend.value = ApiStatus.error;
    }
  }
}
