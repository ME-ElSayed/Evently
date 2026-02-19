import 'package:eventsmanager/core/constants/egypt_governorates.dart';
import 'package:eventsmanager/core/services/api/api_status.dart';
import 'package:eventsmanager/features/events/data/models/event_location_result.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/features/events/presentation/manager/createEvent/base_form_controller.dart';
import 'package:eventsmanager/features/events/presentation/manager/createEvent/capacity_mixin.dart';
import 'package:eventsmanager/features/events/presentation/manager/createEvent/date_time_picker_mixin.dart';
import 'package:eventsmanager/features/events/presentation/manager/createEvent/image_picker_mixin.dart';
import 'package:eventsmanager/features/events/presentation/manager/createdEvents/created_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:latlong2/latlong.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CreateEventController extends BaseFormController
    with ImagePickerMixin, DateTimePickerMixin, CapacityMixin {
  // Text controllers
  final eventName = TextEditingController();
  final eventDescription = TextEditingController();
  final eventLocation = TextEditingController();
  final eventPrice = TextEditingController();
  final eventMaxAttendance = TextEditingController();

  LatLng? eventPosition;
  String? governorate;

  final selectedPaymentMethod = RxnString();
  final selectedDuration = RxnString();
  final isFreeEvent = true.obs;
  final isPublic = true.obs;

  late final EventRepository eventRepo;

  @override
  void onInit() {
    super.onInit();
    eventRepo = Get.find<EventRepository>();

    ever(maxAttendance, (value) {
      eventMaxAttendance.text = value.toString();
    });

    eventMaxAttendance.text = maxAttendance.value.toString();
  }

  void toggleVisibility(bool value) {
    isPublic.value = value;
  }

  void toggleFreePaid() {
    isFreeEvent.value = selectedPaymentMethod.value == "FREE";
    if (isFreeEvent.value) eventPrice.clear();
  }

  void setEventLocation(EventLocationResult result) {
    eventPosition = result.position;
    governorate = result.governorate;

    eventLocation.text =
        '${governorateAliasMap[result.governorate.toLowerCase()]}, '
        '${result.fullAddress}';
  }

  Future<void> createEvent() async {
    if (!validate()) return;

    apiStatus.value = ApiStatus.loading;

    final result = await eventRepo.createEvent(
      name: eventName.text,
      description: eventDescription.text,
      latitude: eventPosition!.latitude,
      longitude: eventPosition!.longitude,
      governorate: governorateAliasMap[governorate!.toLowerCase()]!,
      startAt: selectedDateTime.value!.toUtc(),
      duration: int.parse(selectedDuration.value!.substring(0, 3)),
      maxAttendees: maxAttendance.value,
      visibility: isPublic.value ? "Public" : "Private",
      paymentMethod: selectedPaymentMethod.value!,
      price: isFreeEvent.value ? null : double.parse(eventPrice.text),
      imagePath: pickedFile.value?.path,
    );

    result.fold(
      (e) {
        lastException = e;
        apiStatus.value = ApiStatusMapper.fromException(e);
      },
      (_) {
        apiStatus.value = ApiStatus.success;
        clearForm();
        if (Get.isRegistered<CreatedEventController>()) {
          Get.find<CreatedEventController>().refreshEvents();
        }
        Get.find<PersistentTabController>().jumpToTab(3);
      },
    );
  }

  void clearForm() {
    formKey.currentState?.reset();

    eventName.clear();
    eventDescription.clear();
    eventLocation.clear();
    eventPrice.clear();
    eventMaxAttendance.text = "1";
    eventPosition = null;
    governorate = null;
    selectedPaymentMethod.value = null;
    selectedDuration.value = null;
    isFreeEvent.value = true;
    isPublic.value = true;
    clearDateTime();
    resetCapacity();
    clearImage();
    resetApiState();
  }
}
