import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String content;
  final double? width;
  final double? height;
  final ApiStatus? loading;
  final TextStyle? style;
  final bool? noPadding;
  final void Function()? onTap;
  final Color buttonColor;
  const CustomButton(
      {this.onTap,
      super.key,
      required this.content,
      required this.buttonColor,
      this.width,
      this.height,
      this.loading,
      this.style,
      this.noPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200.w,
      height: height ?? 50.h,
      margin: (noPadding == false || noPadding == null)
          ? EdgeInsets.only(bottom: 25.h)
          : EdgeInsets.zero,
      child: IgnorePointer(
        ignoring: (loading == ApiStatus.loading),
        child: MaterialButton(
          color: buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
          onPressed: onTap,
          child: Center(
            child: (loading != null && loading == ApiStatus.loading)
                ? CircularProgressIndicator(
                    color: AppColors.white,
                  )
                : Text(
                    content,
                    style: style ??
                        TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}
