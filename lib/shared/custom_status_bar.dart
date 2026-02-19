import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomStatusBar extends StatelessWidget {
  final Widget child;
  final Color? statusBarColor;
  final Brightness statusBarIconBrightness;
  final Brightness statusBarBrightness;

  const CustomStatusBar({
    super.key,
    required this.child,
    this.statusBarColor,
    this.statusBarIconBrightness = Brightness.light,
    this.statusBarBrightness = Brightness.dark,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? Colors.transparent,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarBrightness,
      ),
      child: child,
    );
  }
}