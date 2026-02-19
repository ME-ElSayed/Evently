import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/no_events_body.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/pagination_loader.dart';
import 'package:eventsmanager/features/notifications/presentation/manager/invite/invite_notification_controller.dart';
import 'package:eventsmanager/features/notifications/presentation/view/widgets/invites_notification_list.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvitesView extends GetView<InviteNotificationController> {
  const InvitesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiErrorHandlingView(
        status: controller.apiStatusNotifications.value,
        exception: controller.notificationException,
        child: RefreshIndicator(
          onRefresh: () => controller.refreshNotifications(),
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Align(
                alignment: AlignmentGeometry.center,
                child: (controller.unreadInviteCount.value > 0)
                    ? CustomButton(
                        width: 120.w,
                        content: "Mark all read",
                        style:
                            TextStyle(fontSize: 12.sp, color: AppColors.white),
                        buttonColor: AppColors.notification,
                        onTap: () => controller.markAllAsRead(),
                        loading: controller.apiStatusRead.value,
                      )
                    : SizedBox.shrink(),
              ),
            ),
            Obx(() {
              if (!controller.isInitialLoading.value &&
                  controller.items.isEmpty) {
                return NoBody(
                  content: 'There are no invites',
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }),
            Obx(() => InvitesNotificationList(
                notifications: controller.items,
                isLoading: controller.isInitialLoading.value)),
            Obx(() =>
                PaginationLoader(loading: controller.isPaginationLoading.value))
          ]),
        ),
      ),
    );
  }
}
