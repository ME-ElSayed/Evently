import 'package:eventsmanager/core/class/app_bindings.dart';
import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/core/constants/apptheme.dart';
import 'package:eventsmanager/core/localization/change_local.dart';
import 'package:eventsmanager/core/routing/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  await AppBindings.init();

  Get.put(ChangeLocalController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<ChangeLocalController>();

    return ScreenUtilInit(
        //392.7, 737.5
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          final double scale = mediaQuery.textScaler.scale(1).clamp(1.0, 1.2);

          // Compute theme here, after ScreenUtilInit
          final ThemeData currentTheme =
              localeController.isEnglish ? getThemeEnglish() : getThemeArabic();

          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(scale),
            ),
            child: GetMaterialApp(
              locale: localeController.language,
              theme: currentTheme, // Use the computed theme
              title: 'Evently',
              color: AppColors.statusprimary,
              debugShowCheckedModeBanner: false,
              //home: MobileScannerTestPage(),
              getPages: routes,
            ),
          );
        });
  }
}
