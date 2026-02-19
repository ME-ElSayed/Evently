import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/core/constants/app_image_asset.dart';
import 'package:eventsmanager/core/constants/egypt_governorates.dart';
import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/drop_list.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/profile_avatar.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/text_above_field.dart';
import 'package:eventsmanager/features/profileSettings/presentation/manager/profile_settings_controller.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileView extends GetView<ProfileSettingsController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Details",
          style: Get.textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => ApiErrorHandlingView(
            status: controller.apiStatusProfile.value,
            exception: controller.profileException,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.0.h),
              child: Form(
                key: controller.formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => ProfileAvatar(
                        image: (controller.isPicked.value)
                            ? Image.file(
                                controller.pickedFile.value!,
                                width: Get.width,
                                height: Get.height,
                                fit: BoxFit.cover,
                              )
                            : (controller.imageUrl == null)
                                ? Image.asset(AppImageAsset.avatar)
                                : Image(
                                    image: CachedNetworkImageProvider(
                                        controller.imageUrl!),
                                    width: 120.w,
                                    height: 120.h,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
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
                                  ),
                        isLoading: controller.isImageLoading.value,
                        icon: Icons.camera_alt,
                        onPressed: () {
                          controller.pickImage();
                        },
                        onRemove: controller.isPicked.value
                            ? () {
                                controller.removeImage();
                              }
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    //title

                    CustomeTextFormField(
                      labelText: "Full Name",
                      controller: controller.name,
                      hintText: "Enter your name",
                      iconData: Icons.person,
                      valid: (val) => AppValidator.validate(
                          value: val!,
                          type: ValidationType.fullname,
                          min: 2,
                          max: 100),
                      action: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      autofillHints: const [AutofillHints.name],
                    ),
                    TextAboveField(
                        alignment: Alignment.centerLeft, content: "Governate"),
                    Obx(() => DropList(
                          hintText: "Select your Governorate...",
                          items: egyptGovernorates,
                          selectedItem: controller.selectedGovernment.value,
                          onChange: (val) =>
                              controller.selectedGovernment.value = val!,
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomeTextFormField(
                      labelText: "Email address",
                      controller: controller.email,
                      hintText: "name@example.com",
                      iconData: Icons.email,
                      readOnly: true,
                      showcursor: false,
                    ),

                    SizedBox(height: 12.h),
                    CustomButton(
                        buttonColor: AppColors.primary,
                        content: "Save Changes",
                        loading: controller.apiStatusProfile.value,
                        onTap: () {
                          controller.updateUserData();
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
