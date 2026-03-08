import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventImagePic extends StatelessWidget {
  final File? pickedFile;
  final bool isPicked;
  final String? imageUrl;
  final VoidCallback onPress;
  const EventImagePic({
    super.key,
    required this.isPicked,
    required this.onPress,
    this.pickedFile,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        height: 200.h,
        width: double.infinity,
        child: (isPicked)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  pickedFile!,
                  fit: BoxFit.cover,
                ),
              )
            : (imageUrl != null)
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fill,
                    width: double.infinity,
                  )
                : DottedBorder(
                    options: RectDottedBorderOptions(
                      color: AppColors.lightgrey,
                      dashPattern: [5, 6],
                      strokeWidth: .9,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate_outlined,
                              size: 40.r, color: AppColors.primary),
                          SizedBox(height: 10.h),
                          Text(
                            "Tap to upload cover image",
                            style: Get.textTheme.bodySmall!
                                .copyWith(fontSize: 15.sp),
                          )
                        ],
                      ),
                    )),
      ),
    );
  }
}
