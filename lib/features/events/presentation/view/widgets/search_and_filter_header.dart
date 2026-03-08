import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/constants/egypt_Governorates.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/features/events/presentation/manager/searchEvent/search_event_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/custom_search_bar.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/notification_icon.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/toggle_price.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/drop_list.dart';
import 'package:eventsmanager/features/notifications/presentation/manager/notification/notifications_controller.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchAndFilterHeader extends GetView<SearchEventControllerImp> {
  const SearchAndFilterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 230.h,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.65),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r))),
        margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome back",
                    style: Get.textTheme.headlineMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GetX<NotificationsController>(
                    builder: (controller) => NotficationIcon(
                      count: controller.unreadTotalCount.value,
                      onTap: () => Get.toNamed(AppRoutes.notificationsTabView),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 260.w,
                    child: CustomSearchBar(
                      hintText: "Search Event",
                      searchController: controller.searchTextController,
                      onTap: () => controller.goTop(),
                      onSumbit: controller.onSearchSubmit,
                      onChange: (value) {
                        if (value.trim().isEmpty) {
                          controller.searchQuery.value = '';
                        }
                      },
                    ),
                  ),
                  CustomButton(
                    content: "Reset",
                    buttonColor: AppColors.white,
                    style: TextStyle(color: AppColors.black, fontSize: 15.sp),
                    onTap: () => controller.resetFilters(),
                    width: 80.w,
                    noPadding: true,
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Obx(() => Expanded(
                        flex: 4,
                        child: DropList(
                          hintText: "Governorate",
                          items: egyptGovernorates,
                          selectedItem: controller.selectedGovernment.value,
                          onChange: (val) =>
                              controller.selectedGovernment.value = val!,
                        ),
                      )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Obx(
                    () => Expanded(
                      flex: 3,
                      child: TogglePrice(
                        isLeft: controller.priceDown.value,
                        onLeftTap: controller.togglePriceDown,
                        onRightTap: controller.togglePriceUp,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
