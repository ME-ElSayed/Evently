import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class EventsResultsCount extends StatelessWidget {
 final int count;
  const EventsResultsCount({
    super.key, required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Text(
          "$count Events Found",
          style: Get.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
