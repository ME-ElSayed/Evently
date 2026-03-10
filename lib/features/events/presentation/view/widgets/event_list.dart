import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_card.dart';
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
    final items = isLoading
        ? List.generate(
            6,
            (_) => EventModel.dummy(),
          )
        : events;

    return SliverSkeletonizer(
      enabled: isLoading,
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: items.length,
          (context, index) {
            final event = items[index];

            return EventCard(
              event: event,
              ontap: isLoading
                  ? null
                  : () => Get.toNamed(
                        AppRoutes.eventDetails,
                        arguments: {
                          "eventModel": event,
                        },
                      ),
            );
          },
        ),
      ),
    );
  }
}
