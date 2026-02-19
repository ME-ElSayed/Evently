import 'package:eventsmanager/features/events/presentation/manager/attendedEvents/attended_events_controller.dart';
import 'package:eventsmanager/features/events/presentation/manager/createEvent/create_event_controller.dart';
import 'package:eventsmanager/features/events/presentation/manager/createdEvents/created_event_controller.dart';
import 'package:eventsmanager/features/events/presentation/manager/searchEvent/search_event_controller.dart';
import 'package:eventsmanager/features/notifications/presentation/manager/invite/invite_notification_controller.dart';
import 'package:eventsmanager/features/notifications/presentation/manager/notification/notifications_controller.dart';
import 'package:eventsmanager/features/profileSettings/presentation/manager/profile_settings_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // Events
    Get.lazyPut<CreateEventController>(() => CreateEventController());
    Get.lazyPut<SearchEventControllerImp>(() => SearchEventControllerImp());
    Get.lazyPut<AttendedEventsController>(() => AttendedEventsController());
    Get.lazyPut<CreatedEventController>(() => CreatedEventController());
    Get.put(NotificationsController());
    Get.put(InviteNotificationController());

    // Settings
    Get.lazyPut<ProfileSettingsController>(() => ProfileSettingsController());
  }
}
