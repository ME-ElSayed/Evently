import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showMessage(
    String title, String message, Color backgroundcolor, Color textColor) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: backgroundcolor.withOpacity(0.8),
    colorText: textColor,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
  );
}
