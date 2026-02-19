import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/class/hide_nav_bar.dart';
import 'package:eventsmanager/features/events/presentation/manager/searchEvent/search_event_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_list.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/no_events_body.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/pagination_loader.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/search_and_filter_header.dart';
import 'package:eventsmanager/shared/hide_naviagtion_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchEventView extends GetView<SearchEventControllerImp> {
  final HideNavbar hidecontroller;
  const SearchEventView({super.key, required this.hidecontroller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: HideNavigationBar(
        hidecontroller: hidecontroller,
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
                  SearchAndFilterHeader(),
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
                        isLoading: controller.isInitialLoading.value),
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
