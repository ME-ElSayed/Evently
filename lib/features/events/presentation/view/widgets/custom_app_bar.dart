// import 'package:eventsmanager/core/constants/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';

// class CustomAppBar extends StatelessWidget {
//   final String content;
//   const CustomAppBar({
//     super.key, required this.content,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       automaticallyImplyLeading: false,
//       toolbarHeight: 60.h,
//       flexibleSpace: Container(
//         height: 60.h,
//         margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
//         padding: EdgeInsets.only(bottom: 5.h),
//         decoration: BoxDecoration(
//             color: AppColors.primary.withOpacity(0.65),
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30.r),
//                 bottomRight: Radius.circular(30.r))),
//         child: Text(
//           content,
//           textAlign: TextAlign.center,
//           style: Get.textTheme.headlineMedium!.copyWith(
//             color: AppColors.background,
//           ),
//         ),
//       ),
//     );
//   }
//}

import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CustomAppBar extends StatelessWidget {
  final String content;
  const CustomAppBar({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = Get.mediaQuery.padding.top;

    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      floating: false,
      pinned: false,
      snap: false,
      toolbarHeight: 0,
      expandedHeight: 60.h + statusBarHeight,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            Container(
              height: statusBarHeight,
              color: AppColors.primary.withOpacity(0.65),
            ),
            Container(
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.65),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 5.h),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: Get.textTheme.headlineMedium!.copyWith(
                  color: AppColors.background,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
