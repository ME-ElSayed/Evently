import 'package:eventsmanager/features/events/presentation/manager/eventQr/event_qr_contrller.dart';
import 'package:get/get.dart';

class EventQrBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EventQrController());
  }
}
