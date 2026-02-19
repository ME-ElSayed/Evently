import 'dart:ui';
import 'package:flutter/material.dart';

class BlurOverlay extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final String? text;

  final double sigmaX;
  final double sigmaY;
  final Color overlayColor;
  final TextStyle? textStyle;

  const BlurOverlay({
    super.key,
    required this.child,
    this.enabled = true,
    this.text,
    this.sigmaX = 8,
    this.sigmaY = 8,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 0.4),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return Stack(
      fit: StackFit.expand,
      children: [
        child,

        /// Blur layer
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: sigmaX,
            sigmaY: sigmaY,
          ),
          child: Container(
            color: overlayColor,
          ),
        ),

        /// Centered Text
        if (text != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                text!,
                textAlign: TextAlign.center,
                style: textStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
      ],
    );
  }
}