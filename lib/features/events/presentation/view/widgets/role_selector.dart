import 'package:eventsmanager/features/events/data/models/invite_role.dart';
import 'package:eventsmanager/features/events/presentation/manager/sendInvite/send_invite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleSelector extends GetView<SendInviteController> {
  const RoleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Text("Attendee"),
            selected:
                controller.selectedRole.value == InviteRole.ATTENDEE,
            onSelected: (_) => controller.changeRole(InviteRole.ATTENDEE),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ChoiceChip(
            label: const Text("Manager"),
            selected: controller.selectedRole.value == InviteRole.MANAGER,
            onSelected: (_) => controller.changeRole(InviteRole.MANAGER),
          ),
        ),
      ],
    ));
  }
}
