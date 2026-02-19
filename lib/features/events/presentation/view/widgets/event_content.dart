import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/attendace_counter.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_action.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_badge.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_location_card.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/info_card.dart';
import 'package:eventsmanager/features/notifications/data/models/invite_notification_model.dart';
import 'package:eventsmanager/shared/expanded_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class EventContent extends StatelessWidget {
  final InviteNotificationModel? invite;
  final EventModel event;

  const EventContent({super.key, required this.event, this.invite});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 40.w,
            height: 5.h,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
        Row(
          children: [
            EventBadge(
                label: (event.visibility == null)
                    ? ""
                    : event.visibility!.value.toString(),
                color: AppColors.primary),
            SizedBox(width: 8.w),
            EventBadge(
                label: (event.state == null)
                    ? ""
                    : event.state!.value.toString().replaceAll("_", " "),
                color: Colors.green),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          event.name,
          style: Get.textTheme.headlineMedium,
        ),
        SizedBox(height: 16.h),
        AttendanceCounter(
          current: event.currentAttendees,
          total: event.maxAttendees,
        ),
        SizedBox(height: 24.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            SizedBox(
              width: 160.w,
              child: InfoCard(
                icon: Icons.calendar_today,
                label: "Date",
                value:
                    DateFormat('MMM d, yyyy').format(event.startAt.toLocal()),
              ),
            ),
            SizedBox(
              width: 160.w,
              child: InfoCard(
                icon: Icons.access_time,
                label: "Time",
                value: DateFormat('h:mm a').format(event.startAt.toLocal()),
              ),
            ),
            SizedBox(
              width: 160.w,
              child: InfoCard(
                icon: Icons.attach_money,
                label: "Price",
                value: (event.price) ?? "free",
              ),
            ),
            SizedBox(
              width: 160.w,
              child: InfoCard(
                icon: Icons.timer,
                label: "Duration",
                value: "${event.duration} Min",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        ExpandableText(
          text: event.description ?? "",
          maxLines: 3,
          style: Get.textTheme.bodySmall,
        ),
        EventLocationCard(
          title: event.governorate,
          position: LatLng(double.parse(event.latitude ?? "0"),
              double.parse(event.latitude ?? "0")),
        ),
        SizedBox(
          height: 20.h,
        ),
        EventAction(
          eventModel: event,
          invite: invite,
        ),
      ],
    );
  }
}
