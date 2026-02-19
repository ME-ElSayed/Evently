import 'package:eventsmanager/features/notifications/data/models/notification_model.dart';
import 'package:eventsmanager/features/notifications/presentation/view/widgets/invite_notification_card.dart';
import 'package:eventsmanager/features/notifications/presentation/view/widgets/notification_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:skeletonizer/skeletonizer.dart';

class InvitesNotificationList extends StatelessWidget {
  final List<NotificationModel> notifications;
  final bool isLoading;
  const InvitesNotificationList({
    super.key,
    required this.notifications,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: isLoading ? 6 : notifications.length,
        (context, index) {
          if (isLoading) {
            return Skeletonizer(
              enabled: true,
              effect: PulseEffect(
                from: Colors.grey.shade300,
                to: Colors.grey.shade200,
                duration: const Duration(milliseconds: 700),
              ),
              child: const NotificationCardSkeleton(),
            );
          }

          final notification = notifications[index];

          return Padding(
            padding:
                EdgeInsetsGeometry.symmetric(horizontal: 15.w, vertical: 5.h),
            child: InviteNotificationCard(
              notification: notification,
            ),
          );
        },
      ),
    );
  }
}
