import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/features/notifications/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationIcon extends StatelessWidget {
  final NotificationType type;
  const NotificationIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NotificationType.reminder:
        return Icon(
          Icons.timer,
          size: 35.r,
          color: Colors.green,
        );
      case NotificationType.invite:
        return Icon(
          Icons.insert_invitation_rounded,
          size: 35.r,
          color: AppColors.primary,
        );
      case NotificationType.cancellation:
        return Icon(Icons.cancel, size: 35.r, color: Colors.red);
      case NotificationType.system:
        return Icon(Icons.settings, size: 35.r, color: AppColors.darkgrey);
    }
  }
}
