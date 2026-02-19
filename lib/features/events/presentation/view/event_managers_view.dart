import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventManagers/event_managers_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/custom_app_bar.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/managers_list.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/no_events_body.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/pagination_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventManagersView extends GetView<EventManagersController> {
  const EventManagersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Obx(

        ()=> ApiErrorHandlingView(
          status: controller.fetchApiStatus.value,
          exception: controller.fetchException,
          child: RefreshIndicator(
            onRefresh: () => controller.refreshMangers(),
            child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
              CustomAppBar(content: "Managers"),
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
              // no body
              Obx(() {
                if (!controller.isInitialLoading.value && controller.items.isEmpty) {
                  return NoBody(
                    content: 'There are no Managers',
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }),
              ManagersList(
                permissions:controller.event.permissions!,
                  managers: controller.items,
                  isLoading: controller.isInitialLoading.value),
            
              //pagination loader
              Obx(() =>
                  PaginationLoader(loading: controller.isPaginationLoading.value))
            ]),
          ),
        ),
      ),
    );
  }
}
