import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/features/notifications/presentation/view/invites_view.dart';
import 'package:eventsmanager/features/notifications/presentation/view/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NotificationsTabView extends StatelessWidget {
  const NotificationsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.statusprimary,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          title: Text(
            "Notifications",
            style:
                Get.textTheme.headlineMedium!.copyWith(color: AppColors.white),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "general",
                  style:
                      Get.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                ),
              ),
              Tab(
                child: Text(
                  "invites",
                  style:
                      Get.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NotificationsView(),
            InvitesView(),
          ],
        ),
      ),
    );
  }
}
