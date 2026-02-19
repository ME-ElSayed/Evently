import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_card.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_card_skelton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:skeletonizer/skeletonizer.dart';

class EventsList extends StatelessWidget {
  final List<EventModel> events;
  final bool isLoading;
  const EventsList({
    super.key,
    required this.events,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: isLoading ? 6 : events.length,
        (context, index) {
          if (isLoading) {
            return Skeletonizer(
              enabled: true,
              effect: PulseEffect(
                from: Colors.grey.shade300,
                to: Colors.grey.shade200,
                duration: const Duration(milliseconds: 700),
              ),
              child: const EventCardSkeleton(),
            );
          }

          final event = events[index];

          return EventCard(
            event: event,
            ontap: () => Get.toNamed(
              AppRoutes.eventDetails,
              arguments: {
                "eventModel": event,
              },
            ),
          );
        },
      ),
    );
  }
}

