import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/constants/egypt_governorates.dart';
import 'package:eventsmanager/core/constants/app_image_asset.dart';
import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/features/auth/presentation/manager/completeProfile/complete_profile_controller.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_body_auth.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/custome_text_title_auth.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/drop_list.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/profile_avatar.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/text_above_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CompleteProfileView extends GetView<CompleteProfileControllerImp> {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Complete Profile",
          style: Get.textTheme.headlineMedium!.copyWith(fontSize: 22.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => ApiErrorHandlingView(
            status: controller.apiStatus.value,
            exception: controller.lastException,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Form(
                  key: controller.formState,
                  child: Column(
                    children: [
                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3.r),
                        child: StepProgressIndicator(
                          totalSteps: 3,
                          currentStep: 2,
                          selectedColor: AppColors.primary,
                          unselectedColor: AppColors.darkwhite,
                          padding: 0,
                          size: 5.r,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("Step 2 of 3",
                            style: Get.theme.textTheme.bodySmall!
                                .copyWith(fontSize: 15.sp)),
                      ),
                      SizedBox(height: 32.h),
                      //title
                      CustomeTextTitleAuth(
                          content: "Let's set you up",
                          alignment: TextAlign.center),

                      //body
                      CustomeTextBodyAuth(
                          content:
                              "Finalize your profile to start managing\n events and connecting with\n attendees.",
                          alignment: TextAlign.center),

                      // Avatar
                      Obx(
                        () => ProfileAvatar(
                          image: (controller.isPicked.value)
                              ? Image.file(
                                  controller.pickedFile.value!,
                                  width: Get.width,
                                  height: Get.height,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(AppImageAsset.avatar),
                          isLoading: controller.isImageLoading.value,
                          icon: Icons.camera_alt,
                          onPressed: () {
                            controller.pickImage();
                          },
                          onRemove: controller.isPicked.value
                              ? () {
                                  controller.clearImage();
                                }
                              : null,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Text("Upload Photo",
                          style: Get.theme.textTheme.bodySmall!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 32.h),
                      // Form
                      TextAboveField(
                          alignment: Alignment.centerLeft,
                          content: " Governorate"),
                      // group list
                      Obx(() => DropList(
                            hintText: "Select your Governorate...",
                            items: egyptGovernorates,
                            selectedItem: controller.selectedGovernment.value,
                            onChange: (val) =>
                                controller.selectedGovernment.value = val!,
                          )),
                      SizedBox(height: 24.h),

                      CustomeTextFormField(
                        labelText: "Username",
                        hintText: "user_name",
                        iconData: Icons.person,
                        controller: controller.username,
                        valid: (val) => AppValidator.validate(
                            value: val!,
                            type: ValidationType.username,
                            min: 2,
                            max: 30),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButton(
                        buttonColor: AppColors.primary,
                        loading: controller.apiStatus.value,
                        content: "Continue",
                        onTap: () {
                          controller.complete();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
