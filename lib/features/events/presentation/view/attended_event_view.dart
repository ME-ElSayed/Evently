import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/class/hide_nav_bar.dart';
import 'package:eventsmanager/features/events/presentation/manager/attendedEvents/attended_events_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/custom_app_bar.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_list.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/no_events_body.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/pagination_loader.dart';
import 'package:eventsmanager/shared/hide_naviagtion_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AttendedEventView extends GetView<AttendedEventsController> {
  final HideNavbar hideController;
  const AttendedEventView({super.key, required this.hideController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: HideNavigationBar(
        hidecontroller: hideController,
        child: Obx(
          () => ApiErrorHandlingView(
            status: controller.apiStatus.value,
            exception: controller.lastException,
            child: RefreshIndicator(
              onRefresh: () => controller.refreshEvents(),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                controller: controller.scrollController,
                slivers: [
                  CustomAppBar(content: "Attended Events"),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20.h,
                    ),
                  ),
                  Obx(() {
                    if (!controller.isInitialLoading.value &&
                        controller.items.isEmpty) {
                      return NoBody(content: 'There are no events',);
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  }),
                  Obx(
                    () => EventsList(
                      events: controller.items,
                      isLoading: controller.isInitialLoading.value,
                    ),
                  ),
                  Obx(() => PaginationLoader(
                      loading: controller.isPaginationLoading.value))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
