import 'package:eventsmanager/features/notifications/presentation/manager/notification/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SwipeNotification extends GetView<NotificationsController> {
  final int id;
  final Widget child;
  const SwipeNotification({
    super.key,
    required this.child,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key("notification"),
      background: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 25.sp,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Swipe left to delete
          final confirmed = await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Delete!'),
              content:
                  Text('Are you sure you want to delete this notificaton?'),
              actions: [
                TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      //to do
                      controller.deleteNotification(id);
                      Get.back();
                    },
                    child: Text('Delete')),
              ],
            ),
          );
          return confirmed;
        } else {
          return null;
        }
      },
      onDismissed: (direction) {
        // Handle deletion
      },
      child: child,
    );
  }
}
