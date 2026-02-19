import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomeTextTitleAuth extends StatelessWidget {
  final String content;
  final TextAlign alignment;
  const CustomeTextTitleAuth(
      {super.key, required this.content, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: Get.textTheme.headlineLarge,
      textAlign: alignment,
    );
  }
}
