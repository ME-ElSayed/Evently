import 'package:eventsmanager/features/events/data/models/user_search_model.dart';
import 'package:eventsmanager/features/events/presentation/manager/sendInvite/send_invite_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/user_card.dart';
import 'package:eventsmanager/features/notifications/presentation/view/widgets/notification_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'package:skeletonizer/skeletonizer.dart';

class UserSearchList extends StatelessWidget {
  final ScrollController scrollController;
  final List<UserSearchModel> users;
  final bool isLoading;

  const UserSearchList({
    super.key,
    required this.users,
    required this.isLoading,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: isLoading ? 6 : users.length,
      itemBuilder: (context, index) {
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

        final user = users[index];

        return GetX<SendInviteController>(
          builder: (controller) => UserCard(
            isSelected: controller.isSelected(user.id),
            user: user,
            onPress: () => controller.selectedUserId(user.id),
          ),
        );
      },
    );
  }
}
