import 'package:eventsmanager/core/class/hide_nav_bar.dart';
import 'package:flutter/material.dart';

class HideNavigationBar extends StatelessWidget {
  final HideNavbar hidecontroller;
  final Widget child;
  const HideNavigationBar({super.key, required this.hidecontroller, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (n) {
          hidecontroller.onScroll(n.direction);
          return false;
        },
        child: child,
      ),
    );
  }
}
