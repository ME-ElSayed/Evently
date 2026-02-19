import 'package:eventsmanager/shared/circle_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopActions extends StatelessWidget {
  final void Function()? onBackTap;
  final void Function()? onShareTap;

  const TopActions({
    super.key,
    this.onBackTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleIcon(
              icon: Icons.arrow_back_ios_new,
              onTap: onBackTap,
            ),
          ],
        ),
      ),
    );
  }
}
