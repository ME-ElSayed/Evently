import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Convert to functions to ensure .sp is called after ScreenUtilInit
ThemeData getThemeEnglish() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: "PlayfairDisplay",
    scaffoldBackgroundColor: const Color(0xfff8f9fc),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.primary.withOpacity(0.65),
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineLarge: TextStyle(
        fontSize: 35.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      bodySmall: TextStyle(color: AppColors.lightgrey, fontSize: 17.sp),
      // bodyMedium: TextStyle(color: AppColor.lightgrey, fontSize: 20.sp)
    ),
  );
}

ThemeData getThemeArabic() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: "Cairo",
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkgrey,
      ),
      bodySmall: TextStyle(color: AppColors.lightgrey, fontSize: 16.sp),
    ),
  );
}
