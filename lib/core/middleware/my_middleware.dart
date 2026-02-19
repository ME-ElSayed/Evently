import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

class Mymiddleware extends GetMiddleware {
  SharedprefService service = Get.find();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final isLoggedIn = service.isLoggedIn();
    final onboardingCompleted = service.stringGetter(key: "step") == "1";

    // User is logged in → should be at root (or deeper routes)
    if (isLoggedIn && route != AppRoutes.root) {
      return RouteSettings(name: AppRoutes.root);
    }

    //User not logged in, onboarding done → should be at login
    if (!isLoggedIn && onboardingCompleted && route != AppRoutes.login) {
      return RouteSettings(name: AppRoutes.login);
    }

    // User not logged in, onboarding not done → should be at onboarding
    if (!isLoggedIn && !onboardingCompleted && route != AppRoutes.onboarding) {
      return RouteSettings(name: AppRoutes.onboarding);
    }

    // Already at the correct route
    return null;
  }
}

