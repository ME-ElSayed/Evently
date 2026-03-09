import 'package:eventsmanager/features/events/data/models/event_manager_model.dart';
import 'package:eventsmanager/features/events/data/models/event_permission.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/managers_card.dart';
import 'package:eventsmanager/features/notifications/presentation/view/widgets/notification_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ManagersList extends StatelessWidget {
  final bool isLoading;
  final List<EventManagerModel> managers;
  final List<EventPermission> permissions;
  const ManagersList(
      {super.key,
      required this.isLoading,
      required this.managers,
      required this.permissions});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: isLoading ? 4 : managers.length,
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

          final manager = managers[index];

          return Padding(
              padding:
                  EdgeInsetsGeometry.symmetric(horizontal: 10.w, vertical: 5.h),
              child: ManagersCard(
                permissions: permissions,
                manager: manager,
              ));
        },
      ),
    );
  }
}
