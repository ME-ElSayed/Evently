import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomeTextBodyAuth extends StatelessWidget {
  final String content;
  final TextAlign alignment;
  const CustomeTextBodyAuth(
      {super.key, required this.content, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 40.h),
      child: Text(
        content,
        style: Get.theme.textTheme.bodySmall,
        textAlign: alignment,
      ),
    );
  }
}
