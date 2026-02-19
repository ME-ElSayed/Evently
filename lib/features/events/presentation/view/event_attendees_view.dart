import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventAttendees/event_attendess_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/attendees_list.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/custom_app_bar.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/no_events_body.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/pagination_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventAttendeesView extends GetView<EventAttendeesController> {
  const EventAttendeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        ()=>
      ApiErrorHandlingView(
          status: controller.fetchApiStatus.value,
          exception: controller.fetchException,
          child: RefreshIndicator(
            onRefresh: ()=>controller.refreshAttendees(),
            child: CustomScrollView(
                 physics: const AlwaysScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                controller: controller.scrollController,
              slivers: [
              CustomAppBar(content: "Attendees"),
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
              //no body
              Obx(() {
                if (!controller.isInitialLoading.value &&
                    controller.items.isEmpty) {
                  return NoBody(
                    content: 'There are no Attendess'
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }),
              AttendeesList(  
                permissions: controller.event.permissions!,
                attendees: controller.items,
                isLoading: controller.isInitialLoading.value,),
            
             // pagination loader
              Obx(() =>
                  PaginationLoader(loading: controller.isPaginationLoading.value)),
            ]),
          ),
        ),
      ),
    );
  }
}
