import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:flutter/material.dart';

class EventDateTimeField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPick;

  const EventDateTimeField({
    super.key,
    required this.controller,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return CustomeTextFormField(
      controller: controller,
      showcursor: false,
      readOnly: true,
      noPadding: true,
      hintText: "Select date and time",
      labelText: "Start Time",
      onTap: onPick,
      valid: (val) => AppValidator.validate(
        value: val!,
        type: ValidationType.dateAndTime,
      ),
    );
  }
}
