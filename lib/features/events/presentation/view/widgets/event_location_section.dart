import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventLocationSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPickLocation;

  const EventLocationSection({
    super.key,
    required this.controller,
    required this.onPickLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPickLocation,
          child: Container(
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.65),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              "Pick Location",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.black),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        CustomeTextFormField(
          hintText: "Pick location first",
          labelText: "Location",
          iconData: Icons.location_on,
          controller: controller,
          readOnly: true,
          maxlines: 3,
          showcursor: false,
          valid: (val) => AppValidator.validate(
            value: val!,
            type: ValidationType.location,
          ),
        ),
      ],
    );
  }
}
