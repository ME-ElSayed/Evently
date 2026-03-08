import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/constants/app_image_asset.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ProfileAvatar(
        image: imageUrl != null && imageUrl!.isNotEmpty
            ? Image(
                image: CachedNetworkImageProvider(imageUrl!),
                width: 120.w,
                height: 120.h,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    width: 120.w,
                    height: 120.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.w,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImageAsset.avatar,
                    width: 120.w,
                    height: 120.h,
                    fit: BoxFit.cover,
                  );
                },
              )
            : Image.asset(
                AppImageAsset.avatar,
                width: 120.w,
                height: 120.h,
                fit: BoxFit.cover,
              ),
        isLoading: false);
  }
}