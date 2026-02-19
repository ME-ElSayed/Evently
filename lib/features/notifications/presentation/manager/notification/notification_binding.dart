import 'package:eventsmanager/features/notifications/presentation/manager/notification/notifications_controller.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsController());
  }
}
