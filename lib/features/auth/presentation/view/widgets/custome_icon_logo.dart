import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeIconLogo extends StatelessWidget {
  final Color boxColor;
  final Color iconColor;
  final IconData icon;
  const CustomeIconLogo(
      {super.key,
      required this.boxColor,
      required this.iconColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: boxColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: boxColor.withOpacity(0.3),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 40.r,
      ),
    );
  }
}
