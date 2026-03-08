import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';

import 'package:eventsmanager/features/events/presentation/manager/createEvent/image_picker_mixin.dart';
import 'package:eventsmanager/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CompleteProfileController extends GetxController
    with ImagePickerMixin {
  void complete();
}

class CompleteProfileControllerImp extends CompleteProfileController {
  //form
  final formState = GlobalKey<FormState>();
  late TextEditingController username;
  late String name;
  late String email;
  late String password;
  final selectedGovernment = RxnString();
  //api
  late final AuthRepository authRepo;
  final apiStatus = ApiStatus.idle.obs;
  ApiException? lastException;

  @override
  void onInit() {
    username = TextEditingController();
    name = Get.arguments["name"];
    email = Get.arguments["email"];
    password = Get.arguments["password"];
    authRepo = Get.find<AuthRepository>();
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    super.onClose();
  }

  @override
  Future<void> complete() async {
    if (!formState.currentState!.validate()) return;
    if (selectedGovernment.value == null) return;

    apiStatus.value = ApiStatus.loading;
    lastException = null;

    final result = await authRepo.register(
      name: name,
      username: username.text.trim(),
      email: email,
      password: password,
      governorate: selectedGovernment.value!,
      profileImagePath: pickedFile.value?.path,
    );

    result.fold(
      (exception) {
        lastException = exception;
        apiStatus.value = ApiStatusMapper.fromException(exception);
      },
      (_) {
        apiStatus.value = ApiStatus.success;
        Get.toNamed(
          AppRoutes.signupveifycode,
          arguments: {'email': email},
        );
      },
    );
  }
}
