import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventInvites/event_invites_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/custom_app_bar.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/invites_list.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/no_events_body.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/pagination_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventInvitesView extends GetView<EventInvitesController> {
  const EventInvitesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        tooltip: "Send Invite",
        onPressed: () {
          Get.toNamed(AppRoutes.senInvite,
              arguments: {"eventModel": controller.event});
        },
        child: Icon(
          Icons.send,
          color: AppColors.white,
        ),
      ),
      body: Obx(
        () => ApiErrorHandlingView(
          status: controller.fetchApiStatus.value,
          exception: controller.fetchException,
          child: RefreshIndicator(
            onRefresh: () => controller.refreshInvites(),
            child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  CustomAppBar(content: "Invites"),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10.h,
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20.h,
                    ),
                  ),
                  //  // no body
                  Obx(() {
                    if (!controller.isInitialLoading.value &&
                        controller.items.isEmpty) {
                      return NoBody(
                        content: 'There are no invites',
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  }),
                  InvitesList(
                      invites: controller.items,
                      isLoading: controller.isInitialLoading.value),
                  //pagination loader
                  Obx(() => PaginationLoader(
                      loading: controller.isPaginationLoading.value))
                ]),
          ),
        ),
      ),
    );
  }
}
