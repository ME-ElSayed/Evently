import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:flutter/material.dart';

class EventPriceField extends StatelessWidget {
  final TextEditingController controller;
  final bool isFree;
 

  const EventPriceField({
    super.key,
    required this.controller,
    required this.isFree,
  });

  @override
  Widget build(BuildContext context) {
    return CustomeTextFormField(
      controller: controller,
      hintText: isFree ? "Free Event" : "Enter Price",
      labelText: "Price",
      iconData: isFree ? Icons.money_off : Icons.price_change,
      keyboardType: TextInputType.number,
      readOnly: isFree,
      valid: isFree
          ? null
          : (val) => AppValidator.validate(
                value: val!,
                type: ValidationType.price,
              ),
    );
  }
}
