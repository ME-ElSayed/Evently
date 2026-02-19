import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/api/api_status.dart';
import 'package:eventsmanager/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckEmailController extends GetxController {
  goToVerifyCode();
}

class CheckEmailControllerImp extends CheckEmailController {
  //form
  late TextEditingController email;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  //api
  late final AuthRepository authRepo;
  final apiStatus = ApiStatus.idle.obs;
  ApiException? lastException;

  @override
  void onInit() {
    email = TextEditingController();
    authRepo = Get.find<AuthRepository>();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }


  @override
  goToVerifyCode() async {
    if (formState.currentState!.validate()) {
      apiStatus.value = ApiStatus.loading;
      lastException = null;

      final result = await authRepo.forgotPassword(
        email: email.text.trim(),
      );

      result.fold(
        (exception) {
          lastException = exception;
          apiStatus.value = ApiStatusMapper.fromException(exception);
        },
        (_) {
          apiStatus.value = ApiStatus.success;

          Get.toNamed(AppRoutes.forgetPasswordVerifyCode,
              arguments: {"email": email.text.trim()});
        },
      );
    }
  }
}
