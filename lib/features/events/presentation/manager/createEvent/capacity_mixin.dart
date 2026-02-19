import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

mixin CapacityMixin on GetxController {
  final maxAttendance = 1.obs;

  void increment() {
    if (maxAttendance < 10000) maxAttendance.value++;
  }

  void decrement() {
    if (maxAttendance > 1) maxAttendance.value--;
  }

  void setFromText(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1 || parsed > 10000) {
      showMessage(
        "Invalid capacity",
        "Number must be between 1 and 10000",
        Colors.red,
        Colors.black,
      );
      return;
    }
    maxAttendance.value = parsed;
  }

  void resetCapacity() => maxAttendance.value = 1;
}