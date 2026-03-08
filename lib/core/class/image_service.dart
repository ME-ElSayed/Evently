import 'dart:io';

import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ImageService {
  static const int _maxImageSize = 5 * 1024 * 1024; // 5MB

  /// Pick image from camera or gallery, validate, then crop
  static Future<File?> pickAndCropImage() async {
    final pickedFile = await _pickImage();
    if (pickedFile == null) return null;

    if (!_validateImage(pickedFile.path)) return null;

    final cropped = await _cropImage(pickedFile.path);
    if (cropped == null) return null;

    return File(cropped.path);
  }

  // Pick Image 

  static Future<XFile?> _pickImage() {
    return Get.bottomSheet<XFile?>(
      Container(
        color: AppColors.inputBackground,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('From gallery'),
              onTap: () async {
                final file = await ImagePicker()
                    .pickImage(source: ImageSource.gallery);
                Get.back(result: file);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('From camera'),
              onTap: () async {
                final file =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                Get.back(result: file);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Validation 

  static bool _validateImage(String path) {
    final mimeType = lookupMimeType(path);

    if (mimeType != 'image/png' && mimeType != 'image/jpeg') {
      showMessage(
        'Invalid File Type',
        'Please select only PNG or JPG images',
        Colors.red,
        Colors.black,
      );
      return false;
    }

    final file = File(path);
    if (file.lengthSync() > _maxImageSize) {
      showMessage(
        'File Too Large',
        'Image size must be less than 5MB',
        Colors.red,
        Colors.black,
      );
      return false;
    }

    return true;
  }

  //Crop 

  static Future<CroppedFile?> _cropImage(String path) {
    return ImageCropper().cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
          aspectRatioPresets: CropAspectRatioPreset.values,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioPresets: CropAspectRatioPreset.values,
        ),
      ],
    );
  }
}