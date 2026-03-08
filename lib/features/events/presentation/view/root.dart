import 'package:eventsmanager/core/class/hide_nav_bar.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/features/events/presentation/view/attended_event_view.dart';
import 'package:eventsmanager/features/events/presentation/view/create_event_view.dart';
import 'package:eventsmanager/features/events/presentation/view/created_event_view.dart';
import 'package:eventsmanager/features/events/presentation/view/search_event_view.dart';
import 'package:eventsmanager/features/profileSettings/presentation/view/profile_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late final HideNavbar hiding;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  @override
  void initState() {
    hiding = HideNavbar();
    Get.put(controller);
    super.initState();
  }

  @override
  void dispose() {
    hiding.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: hiding.visible,
        builder: (context, value, child) {
          return PersistentTabView(
            margin: (value)
                ? EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h)
                : EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            navBarHeight: (value) ? 80.h : 0,
            resizeToAvoidBottomInset: true,
            isVisible: value,
            context,
            backgroundColor: Color(0xff6c89e6).withOpacity(.85),
            navBarStyle: NavBarStyle.style1,
            decoration: NavBarDecoration(
              colorBehindNavBar: Color(0xff6c89e6),
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.4),
                  blurRadius: 50.r,
                  offset: Offset(10.w, 40.h),
                ),
              ],
            ),
            items: [
              PersistentBottomNavBarItem(
                icon: Icon(
                  Icons.search,
                  size: 28.r,
                ),
                activeColorPrimary: AppColors.white,
                inactiveColorPrimary: AppColors.white.withOpacity(.85),
                title: "Search",
                textStyle: Get.textTheme.bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              PersistentBottomNavBarItem(
                icon: Icon(Icons.how_to_reg_rounded),
                activeColorPrimary: AppColors.white,
                inactiveColorPrimary: AppColors.white.withOpacity(.85),
                title: "Attended",
                textStyle: Get.textTheme.bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              PersistentBottomNavBarItem(
                icon: Icon(
                  Icons.add,
                ),
                activeColorPrimary: AppColors.white,
                inactiveColorPrimary: AppColors.white.withOpacity(.85),
                title: "Create",
                textStyle: Get.textTheme.bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              PersistentBottomNavBarItem(
                icon: Icon(Icons.event_note),
                activeColorPrimary: AppColors.white,
                inactiveColorPrimary: AppColors.white.withOpacity(.85),
                title: "Created",
                textStyle: Get.textTheme.bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              PersistentBottomNavBarItem(
                icon: Icon(Icons.person),
                activeColorPrimary: AppColors.white,
                inactiveColorPrimary: AppColors.white.withOpacity(.85),
                title: "Profile",
                textStyle: Get.textTheme.bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
            controller: controller,
            screens: [
              SearchEventView(
                hidecontroller: hiding,
              ),
              AttendedEventView(
                hideController: hiding,
              ),
              CreateEventView(
                hideController: hiding,
              ),
              CreatedEventView(
                hideController: hiding,
              ),
              ProfileSettingsView(
                hidecontroller: hiding,
              ),
            ],
          );
        });
  }
}
