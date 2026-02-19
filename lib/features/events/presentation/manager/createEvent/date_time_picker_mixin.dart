import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

mixin DateTimePickerMixin on GetxController {
  final Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null);
  final TextEditingController dateTimeController = TextEditingController();

  Future<void> pickDateTime() async {
    final context = Get.context;
    if (context == null) return;

    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final picked = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (!picked.isAfter(DateTime.now())) {
      showMessage(
        "Invalid Time",
        "Please select a future date and time",
        Colors.red,
        Colors.black,
      );
      return;
    }

    selectedDateTime.value = picked;
    dateTimeController.text =
        DateFormat('MMM d, hh:mm a').format(picked);
  }

  void clearDateTime() {
    selectedDateTime.value = null;
    dateTimeController.clear();
  }
}