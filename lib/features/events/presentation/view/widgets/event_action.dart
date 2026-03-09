import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/models/event_role.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_attendance.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_qr_code.dart';
import 'package:eventsmanager/features/notifications/data/models/invite_notification_model.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class EventAction extends StatelessWidget {
  final InviteNotificationModel? invite;
  final EventModel eventModel;

  const EventAction({
    super.key,
    required this.eventModel,
    this.invite,
  });

  @override
  Widget build(BuildContext context) {
    if (invite != null && invite!.status.isPending) {
      return SizedBox.shrink();
    }
    switch (eventModel.role) {
      case null:
        return EventAttendance();
      case EventRole.attendee:
        return EventQrCode(
            onPress: () => Get.toNamed(AppRoutes.qrView,
                arguments: {"eventModel": eventModel}));

      case EventRole.manager:
      case EventRole.owner:
        return CustomButton(
          content: "Dashborad",
          buttonColor: AppColors.primary,
          onTap: () => Get.toNamed(AppRoutes.dashBoard,
              arguments: {"eventModel": eventModel}),
        );
    }
  }
}
