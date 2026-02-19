import 'package:eventsmanager/features/events/presentation/manager/scanQr/scan_qr_controller.dart';
import 'package:get/get.dart';

class ScanQrBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScanQrController());
  }
}
