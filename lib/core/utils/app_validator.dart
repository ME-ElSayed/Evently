import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:get/get.dart';

class AppValidator {
  static String? validate({
    required String value,
    required ValidationType type,
    int? min,
    int? max,
    String? matchWith,
  }) {
    value = value.trim();
    final RegExp nameRegex = RegExp(
      r"^\p{L}+([-'']\p{L}+)*(?: \p{L}+([-'']\p{L}+)*)*$",
      unicode: true,
    );
    if (value.trim().isEmpty) {
      return "This field is required";
    }

    // Length validation (not for email)
    if (type != ValidationType.email) {
      if (min != null && value.length < min) {
        return "Must be at least $min characters";
      }

      if (max != null && value.length > max) {
        return "Must be less than $max characters";
      }
    }

    switch (type) {
      case ValidationType.username:
        if (!GetUtils.isUsername(value)) {
          return "Invalid username";
        }
        break;

      case ValidationType.email:
        if (!GetUtils.isEmail(value)) {
          return "Invalid email address";
        }
        break;

      case ValidationType.phone:
        if (!GetUtils.isPhoneNumber(value)) {
          return "Invalid phone number";
        }
        break;

      case ValidationType.password:
        if (!value.contains(RegExp(r'[A-Z]'))) {
          return "Must contain at least one capital letter";
        }
        if (!value.contains(RegExp(r'[0-9]'))) {
          return "Must contain at least one number";
        }
        break;

      case ValidationType.confirmPassword:
        if (value != matchWith) {
          return "Passwords do not match";
        }
        break;

      case ValidationType.dateAndTime:
        // Add validation for date and time if needed
        break;

      case ValidationType.eventName:
        // Add validation for event name if needed
        break;

      case ValidationType.eventDescription:
        // Add validation for event description if needed
        break;

      case ValidationType.location:
        // Add validation for location if needed
        break;
      case ValidationType.price:
        if (double.parse(value) < 1 || double.parse(value) > 10000) {
          return "value must be between 1 and 10000";
        }
        break;
      case ValidationType.fullname:
        if (!nameRegex.hasMatch(value)) {
          return 'Enter a valid name';
        }

        break;
      case ValidationType.maxAttendance:
        if (int.parse(value) < 1 || int.parse(value) > 10000) {
          return "invalid";
        }
    }

    return null;
  }
}
