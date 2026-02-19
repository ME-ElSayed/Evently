import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_content.dart';
import 'package:eventsmanager/features/notifications/data/models/invite_notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DraggableContent extends StatelessWidget {
  final Future<void> Function()  onRefresh ;
  final EventModel event;

   final InviteNotificationModel? invite;

  const DraggableContent({
    super.key,
    required this.event, this.invite, required this.onRefresh
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.67,
      minChildSize: 0.67,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          child: Container(
            color: Colors.white,
            child: RefreshIndicator(
              onRefresh:onRefresh ,
              child: SingleChildScrollView(
                physics:const AlwaysScrollableScrollPhysics(),
                controller: scrollController,
                padding: EdgeInsets.all(20.r),
                child: EventContent(
                  invite: invite,
                  event: event,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
