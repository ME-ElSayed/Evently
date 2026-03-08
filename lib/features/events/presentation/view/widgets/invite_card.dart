import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/features/events/data/models/event_invite_model.dart';
import 'package:eventsmanager/features/events/data/models/invite_status.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventInvites/event_invites_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_badge.dart';
import 'package:eventsmanager/features/profileSettings/presentation/view/widgets/profile_image.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InviteCard extends GetView<EventInvitesController> {
  final EventInviteModel invite;
  const InviteCard({super.key, required this.invite});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 5.w : 8.w,
            vertical: isSmallScreen ? 5.h : 8.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.black,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.05),
                blurRadius: 4.r,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: ProfileImage(
                          imageUrl: invite.receiver.profileImageUrl)),
                  SizedBox(width: isSmallScreen ? 12.w : 16.w),

                  // Title and timestamp
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        CustomText(
                          text: invite.receiver.name,
                          maxLines: 2,
                          textStyle: Get.textTheme.headlineSmall?.copyWith(
                            fontSize: isSmallScreen ? 18.sp : 20.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        // email
                        CustomText(
                          text: invite.receiver.email,
                          textStyle: TextStyle(
                            fontSize: isSmallScreen ? 16.sp : 18.sp,
                            color: AppColors.black,
                          ),
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        (invite.status == InviteStatus.declined &&
                                invite.senderId == controller.userId)
                            ? GetX<EventInvitesController>(
                                builder: (controller) => CustomButton(
                                  width: 100.w,
                                  height: 40.h,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                  onTap: () =>
                                      controller.resenInvite(invite.id),
                                  content: "resend",
                                  buttonColor: Colors.orange,
                                  noPadding: true,
                                  loading: controller.resendStatus[invite.id],
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Unread indicator
        Positioned(
          top: 5.h,
          right: 10.w,
          child: switch (invite.status) {
            InviteStatus.accepted =>
              EventBadge(label: "accepted", color: Colors.green),
            InviteStatus.declined =>
              EventBadge(label: "declined", color: Colors.red),
            InviteStatus.pending =>
              EventBadge(label: "pending", color: Colors.orange),
          },
        ),
      ],
    );
  }
}
