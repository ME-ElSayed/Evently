import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/text_above_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomeTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final IconData? iconData;
  final bool? noPadding;
  final int? maxlines;
  final TextInputAction? action;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final bool? readOnly;
  final bool? obsecure;
  final bool? showcursor;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final String? Function(String?)? valid;

  final void Function()? onIconTap;
  const CustomeTextFormField(
      {super.key,
      required this.hintText,
      this.iconData,
      this.controller,
      this.valid,
      this.obsecure,
      this.onIconTap,
      this.labelText,
      this.action,
      this.focusNode,
      this.onFieldSubmitted,
      this.keyboardType,
      this.autofillHints,
      this.onTap,
      this.maxlines,
      this.noPadding,
      this.showcursor,
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        (labelText == null)
            ? SizedBox()
            : TextAboveField(
                alignment: Alignment.centerLeft, content: labelText!),
        Padding(
          padding: (noPadding == null || noPadding == false)
              ? EdgeInsets.only(bottom: 25.h)
              : EdgeInsets.zero,
          child: TextFormField(
              maxLines: (maxlines != null) ? maxlines : 1,
              scrollPadding: EdgeInsets.zero,
              readOnly: readOnly ?? false,
              showCursor: showcursor,
              //text input action
              textInputAction: action,
              //focus
              focusNode: focusNode,
              //tap
              onTap: onTap,
              // field submitt
              onFieldSubmitted: onFieldSubmitted,
              obscureText: obsecure ?? false,
              keyboardType: keyboardType,
              autofillHints: autofillHints,
              validator: valid,
              // inputFormatters: (keyboardType == TextInputType.name)
              //     ? [
              //         FilteringTextInputFormatter.allow(
              //             RegExp(r'[a-zA-Z0-9_.]'))
              //       ]
              //     : [],
              controller: controller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                errorMaxLines: 2,
                errorStyle: TextStyle(
                  fontSize: 15.sp,
                  height: 1.2.h,
                ),
                fillColor: AppColors.inputBackground,
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                hintText: hintText,
                hintStyle: Get.textTheme.bodySmall,
                suffixIcon: (iconData != null)
                    ? IconButton(
                        highlightColor: Colors.transparent,
                        enableFeedback: false,
                        onPressed: onIconTap,
                        icon: Icon(
                          iconData,
                          color: AppColors.lightgrey,
                          size: 24.sp,
                        ))
                    : null,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 2.w)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide:
                      BorderSide(color: AppColors.lightgrey, width: 1.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide(color: Colors.blue, width: 2.w),
                ),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 2.w)),
              )),
        ),
      ],
    );
  }
}
