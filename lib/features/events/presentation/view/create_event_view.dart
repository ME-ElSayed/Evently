import 'package:eventsmanager/core/class/api_error_handling_view.dart';
import 'package:eventsmanager/core/class/hide_nav_bar.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/core/constants/event_duration.dart';
import 'package:eventsmanager/core/constants/payment_method_list.dart';
import 'package:eventsmanager/core/routing/routes_name.dart';
import 'package:eventsmanager/core/utils/app_validator.dart';
import 'package:eventsmanager/core/utils/validation_types.dart';
import 'package:eventsmanager/features/events/presentation/manager/createEvent/create_event_controller.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_date_time_field.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_image_pic.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_location_section.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_max_attendance.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/event_price_field.dart';
import 'package:eventsmanager/features/events/presentation/view/widgets/visibility_toggle.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/drop_list.dart';
import 'package:eventsmanager/features/auth/presentation/view/widgets/text_above_field.dart';
import 'package:eventsmanager/shared/custom_button.dart';
import 'package:eventsmanager/shared/custome_text_form_field.dart';
import 'package:eventsmanager/shared/hide_naviagtion_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateEventView extends GetView<CreateEventController> {
  final HideNavbar hideController;
  const CreateEventView({super.key, required this.hideController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: HideNavigationBar(
          hidecontroller: hideController,
          child: SafeArea(
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
                        Obx(
                          () => EventImagePic(
                            isPicked: controller.isPicked.value,
                            pickedFile: controller.pickedFile.value,
                            onPress: () => controller.pickImage(),
                          ),
                        ),
                        SizedBox(height: 24.h),

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
                            content: " Payment"),
                        Obx(() => DropList(
                            hintText: "Payment Method",
                            items: paymentMethodsList,
                            selectedItem:
                                controller.selectedPaymentMethod.value,
                            onChange: (val) {
                              controller.selectedPaymentMethod.value = val!;
                              controller.toggleFreePaid();
                            })),
                        SizedBox(
                          height: 20.h,
                        ),
                        Obx(() => EventPriceField(
                              controller: controller.eventPrice,
                              isFree: controller.isFreeEvent.value,
                            )),
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
                              content: "create Event",
                              loading: controller.apiStatus.value,
                              buttonColor: AppColors.primary,
                              onTap: () {
                                controller.createEvent();
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
