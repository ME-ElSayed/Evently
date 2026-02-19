import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/core/constants/app_image_asset.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final void Function()? ontap;
  const EventCard({
    super.key,
    this.ontap,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: CachedNetworkImage(
                  imageUrl: event.imageUrl ?? AppImageAsset.blankimage,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                  height: 150.h,
                  width: double.infinity,
                )),
            SizedBox(height: 12.h),
            Text(
              DateFormat('dd MMM yyyy • hh:mm a')
                  .format(event.startAt.toLocal()),
              style: Get.textTheme.bodySmall!.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              event.name,
              style: Get.textTheme.headlineMedium!.copyWith(fontSize: 22.sp),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.darkgrey, size: 20.r),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomText(
                    text: event.governorate,
                    textStyle: Get.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    (event.price != null) ? "${event.price} Egp" : "free entry",
                    style: Get.textTheme.bodySmall),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.people, size: 18.r, color: AppColors.primary),
                      SizedBox(width: 6.w),
                      Text(
                        "${event.maxAttendees} Max",
                        style: Get.textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
