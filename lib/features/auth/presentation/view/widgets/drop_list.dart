import 'package:eventsmanager/core/constants/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropList extends StatelessWidget {
  final String hintText;
  final String? selectedItem;
  final List<String> items;
  final void Function(String?)? onChange;
  const DropList(
      {super.key,
      this.onChange,
      required this.hintText,
      this.selectedItem,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
          menuMaxHeight: .65.sh,
          validator: (value) => value == null ? 'Please select a value' : null,
          dropdownColor: AppColors.inputBackground,
          focusColor: AppColors.inputBackground,
          value: selectedItem,
          hint: Text(
            hintText,
            overflow: TextOverflow.ellipsis,
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items
              .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                  value: e, child: Text(e)))
              .toList(),
          onChanged: onChange,
          decoration: InputDecoration(
            fillColor: AppColors.inputBackground,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.only(
                left: 20.w, top: 15.h, bottom: 15.h, right: 10.w),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(color: Colors.transparent, width: 2.w)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: AppColors.lightgrey, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: Colors.blue, width: 2.w),
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(color: Colors.transparent, width: 2.w)),
          )),
    );
  }
}
