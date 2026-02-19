import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight,
    this.textStyle,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextStyle? textStyle;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: (maxLines) ?? 2,
        overflow: TextOverflow.ellipsis,
        textScaler: TextScaler.linear(1.0),
        style: textStyle);
  }
}
