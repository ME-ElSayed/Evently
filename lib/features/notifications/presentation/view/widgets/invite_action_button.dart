import 'package:eventsmanager/features/notifications/presentation/manager/invite/invite_notification_controller.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InviteActionButton extends StatelessWidget {
  final int id;
  const InviteActionButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GetX<InviteNotificationController>(
        builder: (controller) => CustomButton(
          width: 100.w,
          content: "Accept",
          loading: controller.acceptApiStatus[id],
          buttonColor: Colors.green,
          onTap: () =>controller.acceptInvite(id),
          noPadding: true,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(width: 10.w),
      GetX<InviteNotificationController>(
        builder: (controller) => CustomButton(
          width: 100.w,
          content: "Reject",
          noPadding: true,
          loading: controller.rejectApiStatus[id],
          buttonColor: Colors.red,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
          onTap: () =>controller.reJectInvite(id),
        ),
      ),
    ]);
  }
}
