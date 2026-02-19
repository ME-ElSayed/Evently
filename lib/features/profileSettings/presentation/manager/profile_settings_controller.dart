import 'dart:io';
import 'package:eventsmanager/core/class/image_service.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/services/api/api_error_handler.dart';
import 'package:eventsmanager/core/services/api/api_exceptions.dart';
import 'package:eventsmanager/core/services/api/api_status.dart';
import 'package:eventsmanager/features/auth/data/repo/auth_repo.dart';
import 'package:eventsmanager/features/profileSettings/data/models/user_model.dart';
import 'package:eventsmanager/features/profileSettings/data/repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettingsController extends GetxController {
  //form
  final formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  final selectedGovernment = RxnString();
  //api
  late final AuthRepository authRepo;
  late final ProfileRepository profileRepo;
  final apiStatusProfile = ApiStatus.idle.obs;
  final apiStatusLogOut = ApiStatus.idle.obs;
  final user = Rxn<UserModel>();
  String? imageUrl;
  ApiException? profileException;
  ApiException? logoutException;
  //image
  final isPicked = false.obs;
  final pickedFile = Rxn<File>();
  final isImageLoading = false.obs;

  @override
  void onInit() {
    
    authRepo = Get.find<AuthRepository>();
    profileRepo = Get.find<ProfileRepository>();
    name = TextEditingController();
    email = TextEditingController();

    final currentUser = user.value;
    if (currentUser != null) {
      name.text = currentUser.name;
      email.text = currentUser.email;
      selectedGovernment.value = currentUser.governorate;
      imageUrl = currentUser.profileImageUrl;
    } else {
      imageUrl = null;
    }
    loadProfile();
    super.onInit();
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    super.onClose();
  }

  Future<void> loadProfile() async {
    apiStatusProfile.value = ApiStatus.loading;
    profileException = null;

    final result = await profileRepo.getProfile();

    result.fold(
      (exception) {
        profileException = exception;
        apiStatusProfile.value = ApiStatusMapper.fromException(exception);
      },
      (userData) {
        user.value = userData;
        name.text = userData.name;
        email.text = userData.email;
        selectedGovernment.value = userData.governorate;
        imageUrl = userData.profileImageUrl;
        apiStatusProfile.value = ApiStatus.success;
      },
    );
  }

  Future<void> updateUserData() async {
    apiStatusProfile.value = ApiStatus.loading;
    profileException = null;

    final result = await profileRepo.updateProfile(
      name: name.text,
      governorate: selectedGovernment.value,
      profileImagePath: pickedFile.value?.path,
    );

    result.fold(
      (exception) {
        profileException = exception;
        apiStatusProfile.value = ApiStatusMapper.fromException(exception);
      },
      (updatedUser) {
        //  THIS is the important line
        user.value = updatedUser;
        imageUrl = updatedUser.profileImageUrl;

        apiStatusProfile.value = ApiStatus.success;
        isPicked.value = false;
        Get.back();
      },
    );
  }

  Future<void> logOut() async {
    apiStatusLogOut.value = ApiStatus.loading;
    logoutException = null;

    final result = await authRepo.logout();

    result.fold(
      (exception) {
        logoutException = exception;
        apiStatusLogOut.value = ApiStatusMapper.fromException(exception);

        // Show snackbar for logout error
        Get.snackbar(
          'Logout Failed',
          ApiErrorHandler.getUserFriendlyMessage(exception),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          duration: const Duration(seconds: 4),
          mainButton: TextButton(
            onPressed: logOut, // Retry
            child: const Text('Retry'),
          ),
        );
      },
      (_) {
        Get.offAllNamed(AppRoutes.login);
        apiStatusLogOut.value = ApiStatus.success;
      },
    );
  }

  //image
  Future<void> pickImage() async {
    isImageLoading.value = true;

    final image = await ImageService.pickAndCropImage();
    if (image != null) {
      pickedFile.value = image;
      isPicked.value = true;
    }

    isImageLoading.value = false;
  }

  void removeImage() {
    pickedFile.value = null;
    isPicked.value = false;
  }
}
