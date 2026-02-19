import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HideNavbar {
  final ValueNotifier<bool> visible = ValueNotifier(true);

  void onScroll(ScrollDirection direction) {
    if (direction == ScrollDirection.reverse && visible.value) {
      visible.value = false;
    } else if (direction == ScrollDirection.forward && !visible.value) {
      visible.value = true;
    }
  }

  void dispose() => visible.dispose();
}
