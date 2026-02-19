import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventMaxAttendance extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final ValueChanged<String> onChanged;

  const EventMaxAttendance({
    super.key,
    required this.controller,
    required this.onIncrement,
    required this.onDecrement,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Max Attendance",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 20.sp),
        ),
        Row(
          children: [
            CircleButton(icon: Icons.remove, onPressed: onDecrement),
            SizedBox(width: 16.w),
            SizedBox(
              height: 50.h,
              width: 50.w,
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: onChanged,
                decoration: const InputDecoration(border: InputBorder.none),
                validator: (value) => AppValidator.validate(
                    value: value!, type: ValidationType.maxAttendance),
              ),
            ),
            SizedBox(width: 16.w),
            CircleButton(icon: Icons.add, onPressed: onIncrement),
          ],
        ),
      ],
    );
  }
}
