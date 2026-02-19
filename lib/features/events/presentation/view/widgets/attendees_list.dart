import 'package:eventsmanager/features/events/data/models/event_attendee_model.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/attendee_card.dart';
import 'package:eventsmanager/features/notifications/presentation/view/widgets/notification_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AttendeesList extends StatelessWidget {
  final bool isLoading;
  final List<EventAttendeeModel> attendees;
   final List<EventPermission> permissions;
  const AttendeesList({super.key, required this.isLoading, required this.attendees, required this.permissions});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: isLoading ? 6 : attendees.length,
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

           final attendee = attendees[index];

          return Padding(
              padding:
                  EdgeInsetsGeometry.symmetric(horizontal: 10.w, vertical: 5.h),
              child: AttendeeCard(
                permissions:permissions,
                attendee: attendee,
              ));
        },
      ),
    );
  }
}
