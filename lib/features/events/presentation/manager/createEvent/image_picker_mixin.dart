import 'dart:io';

import 'package:eventsmanager/core/class/image_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

mixin ImagePickerMixin on GetxController {
  final isPicked = false.obs;
  final pickedFile = Rxn<File>();
  final isImageLoading = false.obs;

  Future<void> pickImage() async {
    isImageLoading.value = true;

    final image = await ImageService.pickAndCropImage();
    if (image != null) {
      pickedFile.value = image;
      isPicked.value = true;
    }

    isImageLoading.value = false;
  }

  void clearImage() {
    isPicked.value = false;
    pickedFile.value = null;
  }
}