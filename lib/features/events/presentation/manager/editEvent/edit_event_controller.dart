import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/constants/egypt_governorates.dart';
import 'package:eventsmanager/core/extensions/form_auth_scroll.dart';
import 'package:eventsmanager/features/events/data/models/event_location_result.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/features/events/presentation/manager/createEvent/capacity_mixin.dart';
import 'package:eventsmanager/features/events/presentation/manager/createEvent/date_time_picker_mixin.dart';
import 'package:eventsmanager/features/events/presentation/manager/createEvent/image_picker_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class EditEventController extends GetxController
    with ImagePickerMixin, DateTimePickerMixin, CapacityMixin {
  //form
  late EventModel event;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController eventName = TextEditingController();
  final TextEditingController eventDescription = TextEditingController();
  final TextEditingController eventLocation = TextEditingController();
  final TextEditingController eventPrice = TextEditingController();
  final TextEditingController eventMaxAttendance = TextEditingController();
  FocusNode node = FocusNode();
  LatLng? eventPosition;
  String? imageUrl;
  // Observables
  final selectedDuration = RxnString();
  final selectedEventState = RxnString();
  final isFreeEvent = true.obs;
  final selectedPaymentMethod = RxnString();
  final isPublic = true.obs;
  //api
  final apiStatus = ApiStatus.idle.obs;
  ApiException? lastException;
  final EventRepository eventRepo = Get.find<EventRepository>();

  @override
  void onInit() {
    eventMaxAttendance.text = maxAttendance.value.toString();
    event = Get.arguments["eventModel"];
    eventName.text = event.name;
    eventDescription.text = event.description!;
    eventMaxAttendance.text = event.maxAttendees.toString();
    eventLocation.text = event.governorate;
    eventPosition = LatLng(
      double.parse(event.latitude!),
      double.parse(event.longitude!),
    );
    dateTimeController.text =
        DateFormat('MMM d, hh:mm a').format(event.startAt);
    selectedDateTime.value = event.startAt;
    selectedDuration.value = "${event.duration} Minutes";
    eventPrice.text = event.price ?? "0";
    imageUrl = event.imageUrl;
    maxAttendance.value = event.maxAttendees;
    selectedPaymentMethod.value = event.paymentMethod!.value.toString();
    isPublic.value = (event.visibility == EventVisibility.public);
    selectedEventState.value = (event.state != EventState.ongoing &&
            event.state != EventState.completed)
        ? event.state!.value
        : null;
    // keep TextField in sync with Rx
    ever(maxAttendance, (value) {
      eventMaxAttendance.text = value.toString();
    });

    super.onInit();
  }

  @override
  void onClose() {
    eventName.dispose();
    eventDescription.dispose();
    eventLocation.dispose();
    super.onClose();
  }

  void toggleFreePaid() {
    isFreeEvent.value = selectedPaymentMethod.value == "FREE";
    if (isFreeEvent.value) eventPrice.clear();
  }

//Visibility
  void toggleVisibility(bool value) {
    isPublic.value = value;
  }

  Future<void> updateEvent() async {
    if (!formKey.validateAndScroll()) return;
    apiStatus.value = ApiStatus.loading;

    final result = await eventRepo.updateEvent(
        eventId: event.id,
        name: eventName.text.trim(),
        description: eventDescription.text.trim(),
        latitude: eventPosition!.latitude,
        longitude: eventPosition!.longitude,
        governorate: governorateAliasMap[
            eventLocation.text.split(',').first.toLowerCase()]!,
        startAt: selectedDateTime.value!.toUtc(),
        duration: int.parse(selectedDuration.value!.substring(0, 3)),
        maxAttendees: int.parse(eventMaxAttendance.text),
        visibility: isPublic.value ? "PUBLIC" : "PRIVATE",
        imagePath: pickedFile.value?.path,
        state: selectedEventState.value);

    result.fold(
      (e) {
        lastException = e;
        apiStatus.value = ApiStatusMapper.fromException(e);
      },
      (updatedEvent) {
        apiStatus.value = ApiStatus.success;

        // Return updated event to previous screen
        Get.back();
      },
    );
  }

  //location
  void setEventLocation(EventLocationResult result) {
    eventPosition = result.position;
    eventLocation.text = '${result.governorate}, ${result.fullAddress}';
  }
}
