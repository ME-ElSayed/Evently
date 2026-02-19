import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CustomSearchBar extends StatelessWidget {
  final String? hintText;
  final TextEditingController searchController;
  final void Function(String)? onSumbit;
  final void Function(String)? onChange;
  final void Function()? onTap;
  const CustomSearchBar(
      {super.key,
      this.onTap,
      this.onSumbit,
      required this.searchController,
      this.onChange, this.hintText});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: searchController,
      leading: Icon(Icons.search),
      hintText: hintText,
      hintStyle: MaterialStateProperty.all(Get.textTheme.bodySmall),
      elevation: MaterialStateProperty.all(.5),
      backgroundColor: MaterialStateProperty.all(AppColors.inputBackground),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 16.w),
      ),
      onTap: onTap,
      onSubmitted: onSumbit,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: onChange,
    );
  }
}
