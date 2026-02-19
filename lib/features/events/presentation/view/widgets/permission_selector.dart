import 'package:eventsmanager/features/events/data/models/invite_role.dart';
import 'package:eventsmanager/features/events/data/models/manager_permission_list.dart';
import 'package:eventsmanager/features/events/presentation/manager/sendInvite/send_invite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PermissionSelector extends StatelessWidget {
  final SendInviteController controller;

  const PermissionSelector({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Obx(() {
      if (controller.selectedRole.value != InviteRole.MANAGER) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Manager Permissions",
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: managerPermissionList.map((permission) {
              final isSelected =
                  controller.selectedPermissions.contains(permission);

              return FilterChip(
                label: Text(
                  permission.displayName,
                  style: Get.textTheme.headlineSmall!.copyWith(fontSize: 15.sp),
                ),
                selected: isSelected,
                onSelected: (_) => controller.togglePermission(permission),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
