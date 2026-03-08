import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/theme/app_colors.dart';
import 'package:eventsmanager/features/events/presentation/manager/scanQr/scan_qr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScanQrView extends GetView<ScanQrController> {
  const ScanQrView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "QR Scanner",
          style: Get.textTheme.headlineMedium!.copyWith(color: AppColors.white),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: controller.scannerController,
            builder: (context, state, _) {
              return IconButton(
                icon: Icon(
                  state.torchState == TorchState.on
                      ? Icons.flash_on
                      : Icons.flash_off,
                  color: AppColors.white,
                ),
                onPressed: controller.toggleTorch,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch, color: AppColors.white),
            onPressed: controller.switchCamera,
          ),
        ],
      ),
      body: Stack(
        children: [
          /// Camera
          MobileScanner(
            controller: controller.scannerController,
            onDetect: controller.onDetect,
          ),

          /// Overlay
          const _ScannerOverlay(),

          /// Bottom Status Panel
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              final status = controller.verifyStatus.value;

              String text = "Scan a QR Code";
              Color color = Colors.white;
              Widget? action;
              Widget? icon;

              switch (status) {
                case ApiStatus.loading:
                  text = "Verifying...";
                  color = Colors.orange;
                  icon = SizedBox(
                    height: 26.h,
                    width: 26.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.orange,
                    ),
                  );
                  break;

                case ApiStatus.success:
                  text = "Attendance Verified";
                  color = Colors.greenAccent;
                  icon = Icon(Icons.check_circle,
                      color: Colors.greenAccent, size: 40.sp);
                  break;

                case ApiStatus.error:
                  text = "Invalid QR Code";
                  color = Colors.redAccent;
                  icon =
                      Icon(Icons.cancel, color: Colors.redAccent, size: 40.sp);

                  action = Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: controller.scanAgain,
                      child: const Text("Try Again"),
                    ),
                  );
                  break;

                default:
                  break;
              }

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.9),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) icon,
                    if (icon != null) SizedBox(height: 12.h),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style:
                          Get.textTheme.headlineMedium!.copyWith(color: color),
                    ),
                    if (action != null) action,
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ScannerOverlay extends StatelessWidget {
  const _ScannerOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: const ShapeDecoration(
          shape: _ScannerBorderShape(),
        ),
      ),
    );
  }
}

class _ScannerBorderShape extends ShapeBorder {
  const _ScannerBorderShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const cutoutSize = 250.0;

    final cutoutRect = Rect.fromCenter(
      center: rect.center,
      width: cutoutSize,
      height: cutoutSize,
    );

    return Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()
        ..addRRect(
          RRect.fromRectXY(cutoutRect, 16, 16),
        ),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawPath(getOuterPath(rect), overlayPaint);

    final borderPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    const cutoutSize = 250.0;

    final cutoutRect = Rect.fromCenter(
      center: rect.center,
      width: cutoutSize,
      height: cutoutSize,
    );

    canvas.drawRRect(
      RRect.fromRectXY(cutoutRect, 16, 16),
      borderPaint,
    );
  }

  @override
  ShapeBorder scale(double t) => this;
}
