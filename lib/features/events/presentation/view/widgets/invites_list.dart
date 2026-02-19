import 'package:eventsmanager/features/events/data/models/event_invite_model.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/invite_card.dart';
import 'package:eventsmanager/features/notifications/presentation/view/widgets/notification_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InvitesList extends StatelessWidget {
  final List<EventInviteModel> invites;
  final bool isLoading;
  const InvitesList({super.key, required this.isLoading, required this.invites});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: isLoading ? 6 : invites.length,
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

            final invite = invites[index];

          return Padding(
              padding:
                  EdgeInsetsGeometry.symmetric(horizontal: 10.w, vertical: 5.h),
              child: InviteCard(invite: invite,));
        },
      ),
    );
  }
}
