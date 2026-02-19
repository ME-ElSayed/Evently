import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/class/hide_nav_bar.dart';
import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/services/api/api_status.dart';
import 'package:eventsmanager/features/profileSettings/presentation/manager/profile_settings_controller.dart';
import 'package:eventsmanager/features/profileSettings/presentation/view/widgets/profile_image.dart';
import 'package:eventsmanager/features/profileSettings/presentation/view/widgets/section.dart';
import 'package:eventsmanager/features/profileSettings/presentation/view/widgets/settings_tile.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/shared/custom_text.dart';
import 'package:eventsmanager/shared/hide_naviagtion_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileSettingsView extends GetView<ProfileSettingsController> {
  final HideNavbar hidecontroller;
  const ProfileSettingsView({super.key, required this.hidecontroller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HideNavigationBar(
        hidecontroller: hidecontroller,
        child: SafeArea(child: Obx(() {
          final user = controller.user.value;
          final imageUrl = user?.profileImageUrl;

          return ApiErrorHandlingView(
            status: controller.apiStatusProfile.value,
            exception: controller.profileException,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              child: Skeletonizer(
                enabled:
                    (controller.apiStatusProfile.value == ApiStatus.loading),
                effect: PulseEffect(
                  from: Colors.grey.shade300,
                  to: Colors.grey.shade200,
                  duration: const Duration(milliseconds: 700),
                ),
                child: Column(
                  children: [
                    // ---------- PROFILE HEADER ----------
                    Column(
                      children: [
                        ProfileImage(imageUrl: imageUrl),
                        SizedBox(height: 12.h),
                        CustomText(
                          text: user?.email ?? "",
                          textStyle: Get.textTheme.headlineSmall,
                          maxLines: 1,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on,
                                size: 25.r, color: AppColors.darkgrey),
                            SizedBox(width: 4.w),
                            Text(
                              user?.governorate ?? "",
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // ---------- PREFERENCES ----------
                    Section(
                      title: 'Preferences',
                      children: [
                        SettingsTile(
                          icon: Icons.language,
                          title: 'Language',
                          trailingText: 'English',
                        ),
                        SettingsTile(icon: Icons.sunny, title: "theme"),
                        SettingsTile(
                          icon: Icons.notifications,
                          title: 'Notifications',
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // ---------- ACCOUNT ----------
                    Section(
                      title: 'Account',
                      children: [
                        SettingsTile(
                          icon: Icons.person,
                          title: 'Personal Details',
                          onPress: () => Get.toNamed(AppRoutes.editprofile),
                        ),
                        SettingsTile(
                          icon: Icons.admin_panel_settings,
                          title: 'Manage Roles',
                          subtitle: 'Attendee',
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),
                    Obx(
                      () => CustomButton(
                        content: "Log Out",
                        buttonColor: Colors.red,
                        loading: controller.apiStatusLogOut.value,
                        onTap: () {
                          controller.logOut();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        })),
      ),
    );
  }
}
