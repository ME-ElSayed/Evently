import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventDashboard/event_dashboard_controller.dart';
import 'package:eventsmanager/features/profileSettings/presentation/view/widgets/section.dart';
import 'package:eventsmanager/features/profileSettings/presentation/view/widgets/settings_tile.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardView extends GetView<EventDashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: Get.textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        tooltip: "Scan Qr To Verify attendance",
        onPressed: () => Get.toNamed(AppRoutes.scanQrView,
            arguments: {"eventModel": controller.event}),
        child: Icon(
          Icons.qr_code,
          size: 25.r,
          color: AppColors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w, vertical: 50.h),
        child: ListView(
          children: [
            // ---------- PREFERENCES ----------
            Section(
              title: 'Event Setup',
              children: [
                SettingsTile(
                  icon: Icons.event,
                  title: 'Edit Details',
                  onPress: () => Get.toNamed(AppRoutes.editEvent,
                      arguments: {"eventModel": controller.event}),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // ---------- ACCOUNT ----------
            Section(
              title: 'Management',
              children: [
                SettingsTile(
                  icon: Icons.people,
                  title: 'Attendees',
                  onPress: () => Get.toNamed(AppRoutes.eventAttendees,
                      arguments: {"eventModel": controller.event}),
                ),
                SettingsTile(
                    icon: Icons.admin_panel_settings,
                    title: 'Managers',
                    onPress: () => Get.toNamed(AppRoutes.eventManagers,
                        arguments: {"eventModel": controller.event})),
                SettingsTile(
                    icon: Icons.email,
                    title: 'Invites',
                    onPress: () => Get.toNamed(AppRoutes.eventInvites,
                        arguments: {"eventModel": controller.event})),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: AlignmentGeometry.center,
              child: Obx(
                () => CustomButton(
                  content: "Leave Event",
                  buttonColor: Colors.red,
                  onTap: () => controller.leaveEvent(),
                  loading: controller.leaveApiStatus.value,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
