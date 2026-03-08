import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/toggle_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TogglePrice extends StatelessWidget {
  final bool? isLeft;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  const TogglePrice({
    super.key,
    required this.isLeft,
    required this.onLeftTap,
    required this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: 140.w,
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
        color: AppColors.darkwhite,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            alignment: isLeft == null
                ? Alignment.center
                : isLeft!
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isLeft == null ? 0 : 1,
              child: Container(
                height: 50.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              ToggleIcon(
                icon: Icons.trending_down,
                selected: isLeft == true,
                onTap: onLeftTap,
              ),
              const Spacer(),
              ToggleIcon(
                icon: Icons.trending_up,
                selected: isLeft == false,
                onTap: onRightTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
