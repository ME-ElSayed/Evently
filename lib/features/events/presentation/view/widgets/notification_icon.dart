import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotficationIcon extends StatelessWidget {
  final void Function()? onTap;
  const NotficationIcon({
    super.key,
    required this.count,
    this.onTap,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.notifications,
            color: AppColors.white,
            size: 35.r,
          ),
          if (count > 0)
            Positioned(
              right: 2,
              top: -7,
              child: Container(
                padding: EdgeInsets.all(4.r),
                constraints: BoxConstraints(
                  minWidth: 18.r,
                  minHeight: 18.r,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    count > 99 ? '99+' : count.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
