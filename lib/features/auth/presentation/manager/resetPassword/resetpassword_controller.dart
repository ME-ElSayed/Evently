import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/extensions/form_auth_scroll.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/api/api_status.dart';
import 'package:eventsmanager/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ResetpasswordController extends GetxController {
  resetPassword();
}

class ResetpasswordControllerImp extends ResetpasswordController {
  //form
  late TextEditingController password;
  late TextEditingController confirmPassword;
  bool isShowPassword = true;
  bool isShowConfirmPassword = true;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  late String email;
  //api
  late final AuthRepository authRepo;
  final apiStatus = ApiStatus.idle.obs;
  ApiException? lastException;
  showPassword() {
    isShowPassword = (isShowPassword) ? false : true;
    update();
  }

  showConfirmPassword() {
    isShowConfirmPassword = (isShowConfirmPassword) ? false : true;
    update();
  }

  @override
  resetPassword() async {
    if (formState.validateAndScroll()) {
      apiStatus.value = ApiStatus.loading;
      lastException = null;

      final result = await authRepo.resetPassword(
        password: password.text.trim(),
      );

      result.fold(
        (exception) {
          lastException = exception;
          apiStatus.value = ApiStatusMapper.fromException(exception);
        },
        (_) {
          apiStatus.value = ApiStatus.success;

          Get.offAllNamed(AppRoutes.restpasswordsuccess);
        },
      );
    }
  }


  @override
  void onInit() {
    password = TextEditingController();
    confirmPassword = TextEditingController();
    email = Get.arguments["email"];
    authRepo = Get.find<AuthRepository>();
    super.onInit();
  }

  @override
  void onClose() {
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
