import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/constants/event_duration.dart';
import 'package:eventsmanager/core/constants/event_state_list.dart';
import 'package:eventsmanager/core/functions/is_event_static.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/features/events/presentation/manager/editEvent/edit_event_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_date_time_field.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_image_pic.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_location_section.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_max_attendance.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/visibility_toggle.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/drop_list.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/text_above_field.dart';
import 'package:eventsmanager/shared/blur_overlay.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class EditEventView extends GetView<EditEventController> {
  const EditEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlurOverlay(
        enabled: (isEventStatic(eventState: controller.event.state!)),
        text: "You can`not edit any more ",
        textStyle:
            Get.textTheme.headlineMedium!.copyWith(color: AppColors.white),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Obx(
              () => ApiErrorHandlingView(
                status: controller.apiStatus.value,
                exception: controller.lastException,
                child: SingleChildScrollView(
                  //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    20.w,
                    20.h,
                    20.w,
                    MediaQuery.of(context).viewInsets.bottom + 50.h,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => EventImagePic(
                              isPicked: controller.isPicked.value,
                              pickedFile: controller.pickedFile.value,
                              imageUrl: controller.imageUrl,
                              onPress: () => controller.pickImage(),
                            )),
                        SizedBox(height: 24.h),
                        Obx(() => (controller.isPicked.value ||
                                controller.imageUrl != null)
                            ? Align(
                                alignment: AlignmentGeometry.center,
                                child: CustomButton(
                                    content: "clear image",
                                    buttonColor: Colors.red,
                                    onTap: () {
                                      controller.clearImage();
                                      controller.imageUrl = null;
                                    }),
                              )
                            : SizedBox.shrink()),

                        CustomeTextFormField(
                          hintText: "e.g.,Music Festival",
                          iconData: Icons.event,
                          labelText: "Evnent Name",
                          controller: controller.eventName,
                          valid: (val) => AppValidator.validate(
                            value: val!,
                            type: ValidationType.eventName,
                            min: 2,
                            max: 50,
                          ),
                        ),

                        CustomeTextFormField(
                            maxlines: 5,
                            hintText: "Tell people what your event is about...",
                            labelText: "Description",
                            controller: controller.eventDescription,
                            valid: (val) => AppValidator.validate(
                                  value: val!,
                                  type: ValidationType.eventDescription,
                                  min: 20,
                                  max: 1000,
                                )),

                        EventLocationSection(
                          controller: controller.eventLocation,
                          onPickLocation: () async {
                            final result = await Get.toNamed(AppRoutes.map);
                            if (result != null) {
                              controller.setEventLocation(result);
                            }
                          },
                        ),

                        TextAboveField(
                            alignment: Alignment.centerLeft,
                            content: "EventState"),

                        Obx(() => DropList(
                            hintText: "event state",
                            items: eventStatesList,
                            selectedItem: controller.selectedEventState.value,
                            onChange: (val) {
                              controller.selectedEventState.value = val;
                            })),
                        SizedBox(
                          height: 20.h,
                        ),
                        //DateTime and duration
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  EventDateTimeField(
                                      controller: controller.dateTimeController,
                                      onPick: () => controller.pickDateTime())
                                ],
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextAboveField(
                                      alignment: Alignment.centerLeft,
                                      content: " Duration"),
                                  Obx(() => DropList(
                                        hintText: "Select Duration",
                                        items: eventDurations,
                                        selectedItem:
                                            controller.selectedDuration.value,
                                        onChange: (val) => controller
                                            .selectedDuration.value = val!,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32.h),

                        //Attendance
                        EventMaxAttendance(
                            controller: controller.eventMaxAttendance,
                            onIncrement: () => controller.increment(),
                            onDecrement: () => controller.decrement(),
                            onChanged: controller.setFromText),
                        SizedBox(height: 24.h),

                        //visiblity
                        TextAboveField(
                            alignment: Alignment.centerLeft,
                            content: "visiblity"),
                        Obx(() => VisibilityToggle(
                              isPublic: controller.isPublic.value,
                              onChanged: controller.toggleVisibility,
                            )),
                        SizedBox(height: 40.h),

                        //submit

                        Center(
                          child: CustomButton(
                              loading: controller.apiStatus.value,
                              content: "Edit Event",
                              buttonColor: AppColors.primary,
                              onTap: () {
                                controller.updateEvent();
                              }),
                        ),
                      ],
                    ),
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
