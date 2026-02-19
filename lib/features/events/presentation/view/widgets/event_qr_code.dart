import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:flutter/material.dart';

class EventQrCode extends StatelessWidget {
  final VoidCallback onPress;
  const EventQrCode({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      content: "Show Qr",
      buttonColor: AppColors.primary,
      onTap: onPress,
    );
  }
}
