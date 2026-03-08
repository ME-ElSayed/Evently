import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/constants/app_image_asset.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventDetails/event_details_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/draggable_content.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/top_actions.dart';
import 'package:eventsmanager/shared/custom_status_bar.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventDetailsView extends GetView<EventDetailsController> {
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomStatusBar(
      statusBarColor: AppColors.statusprimary,
      statusBarIconBrightness: Brightness.light,
      child: Scaffold(
        body: Obx(
          () {
            final status = controller.detailsApiStatus.value;
            final event = controller.event.value ?? EventModel.dummy();
            return ApiErrorHandlingView(
              status: status,
              exception: controller.detailsException,
              child: Skeletonizer(
                enabled: status == ApiStatus.loading,
                effect: PulseEffect(
                  from: Colors.grey.shade300,
                  to: Colors.grey.shade200,
                  duration: const Duration(milliseconds: 700),
                ),
                child: Stack(
                  children: [
                    // TOP IMAGE
                    Container(
                      padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                      height: 300.h,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: event.imageUrl ?? AppImageAsset.blankimage,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),

                    // TOP ACTIONS
                    TopActions(
                      onBackTap: () => Get.back(),
                    ),

                    // CONTENT SHEET
                    DraggableContent(
                      onRefresh:()=> controller.fetchEventDetails(),
                      event: event,
                      invite: controller.invite.value,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
