import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/functions/is_event_static.dart';
import 'package:eventsmanager/features/events/data/models/invite_role.dart';
import 'package:eventsmanager/features/events/presentation/manager/sendInvite/send_invite_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/custom_search_bar.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/permission_selector.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/role_selector.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/user_search_list.dart';
import 'package:eventsmanager/shared/blur_overlay.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/shared/custom_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SendInviteView extends GetView<SendInviteController> {
  const SendInviteView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomStatusBar(
      statusBarColor: AppColors.statusprimary,
      statusBarIconBrightness: Brightness.light,
      child: BlurOverlay(
        enabled: (isEventStatic(eventState: controller.event.state!)),
        text: "You can`not send invite any more ",
        textStyle:
            Get.textTheme.headlineMedium!.copyWith(color: AppColors.white),
        child: Scaffold(
          body: SafeArea(
            child: Obx(
              () => ApiErrorHandlingView(
                status: controller.fetchApiStatus.value,
                exception: controller.fetchException,
                child: RefreshIndicator(
                  onRefresh: () => controller.refreshInvites(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: 125.h,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.65),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.r),
                              bottomRight: Radius.circular(30.r),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          child: Column(
                            children: [
                              Text(
                                "search for user",
                                style: Get.textTheme.headlineMedium!
                                    .copyWith(color: AppColors.white),
                              ),
                              SizedBox(height: 10.h),
                              CustomSearchBar(
                                  hintText: "search user",
                                  searchController: controller.searchControl,
                                  onSumbit: controller.onSearchSubmit,
                                  onChange: (value) {
                                    if (value.trim().isEmpty) {
                                      controller.searchQuery.value = '';
                                    }
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Obx(() {
                          if (!controller.isInitialLoading.value &&
                              controller.items.isEmpty) {
                            return Center(
                              child: Text('There are no users start search'),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                        SizedBox(
                          height: 500.h,
                          child: UserSearchList(
                            scrollController: controller.scrollController,
                            users: controller.items,
                            isLoading: controller.isInitialLoading.value,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Obx(() => controller.selectedUserId.value != null
                            ? RoleSelector()
                            : const SizedBox.shrink()),
                        SizedBox(height: 12.h),
                        Obx(() {
                          if (controller.selectedRole.value !=
                              InviteRole.MANAGER) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: PermissionSelector(controller: controller),
                          );
                        }),
                        SizedBox(height: 12.h),
                        Obx(
                          () => (controller.items.isNotEmpty)
                              ? CustomButton(
                                  loading: controller.sendApiStatus.value,
                                  buttonColor: AppColors.primary,
                                  content: "Send",
                                  onTap: () => controller.sendInvite(),
                                )
                              : SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
