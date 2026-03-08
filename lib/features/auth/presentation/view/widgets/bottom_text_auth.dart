import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BottomTextAuth extends StatelessWidget {
  final String text1;
  final String text2;
  final void Function()? onTap;
  const BottomTextAuth(
      {super.key, required this.text1, required this.text2, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              overlayColor: Colors.transparent,
              padding: EdgeInsets.zero,
            ),
            child: Text(
              text2,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.primary),
            )),
      ],
    );
  }
}
