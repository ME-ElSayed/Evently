import 'package:eventsmanager/core/api/api_error_handler.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/core/functions/show_message.dart';
import 'package:flutter/material.dart';

class ScanQrController extends GetxController
    with WidgetsBindingObserver {

  late final MobileScannerController scannerController;
  final EventRepository _eventRepository = Get.find<EventRepository>();

  late final EventModel event;

  final RxnString scannedCode = RxnString();
  final RxBool isProcessing = false.obs;
  final RxBool isVerifying = false.obs;
  final RxnBool isValid = RxnBool();
  final Rx<ApiStatus> verifyStatus = ApiStatus.idle.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    event = Get.arguments["eventModel"];

    scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    scannerController.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!scannerController.value.isInitialized) return;

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      scannerController.stop();
    } else if (state == AppLifecycleState.resumed) {
      scannerController.start();
    }
  }

  Future<void> onDetect(BarcodeCapture capture) async {
    if (isProcessing.value) return;

    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final code = barcodes.first.rawValue;
    if (code == null || code == scannedCode.value) return;

    isProcessing.value = true;
    scannedCode.value = code;

    await scannerController.stop();

    await verifyQr(code);
  }


  Future<void> verifyQr(String qr) async {
    try {
      isVerifying.value = true;
      isValid.value = null;
      verifyStatus.value = ApiStatus.loading;

      final result = await _eventRepository.verifyAttendance(
        eventId: event.id,
        attendanceCode: qr,
      );

      result.fold(
        (exception) async {
          verifyStatus.value =
              ApiStatusMapper.fromException(exception);

          isValid.value = false;

          showMessage(
            "Verification Failed",
            ApiErrorHandler.getUserFriendlyMessage(exception),
            Colors.red,
            Colors.white,
          );

          await Future.delayed(const Duration(seconds: 2));
          scanAgain();
        },
        (_) async {
          verifyStatus.value = ApiStatus.success;
          isValid.value = true;

          showMessage(
            "Success",
            "Attendance verified successfully",
            Colors.green,
            Colors.white,
          );
        },
      );
    } catch (_) {
      verifyStatus.value = ApiStatus.error;
      isValid.value = false;

      await Future.delayed(const Duration(seconds: 2));
      scanAgain();
    } finally {
      isVerifying.value = false;
      isProcessing.value = false;
    }
  }

  Future<void> scanAgain() async {
    scannedCode.value = null;
    isValid.value = null;
    verifyStatus.value = ApiStatus.idle;
    await scannerController.start();
  }

  void toggleTorch() => scannerController.toggleTorch();
  void switchCamera() => scannerController.switchCamera();
}