import 'package:eventsmanager/core/constants/app_colors.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventQr/event_qr_contrller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventQrView extends GetView<EventQrController> {
  const EventQrView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Your QR Code'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(24).r,
          padding: EdgeInsets.all(24).r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                blurRadius: 20.r,
                offset: const Offset(0, 10),
                color: Colors.black.withOpacity(0.08),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Scan Me', style: Get.textTheme.headlineMedium),
              const SizedBox(height: 16),

              /// QR Code
              RepaintBoundary(
                key: controller.qrKey,
                child: QrImageView(
                  data: controller.data,
                  size: 220.r,
                  backgroundColor: Colors.white,
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(
                    icon: Icons.download,
                    label: 'Download',
                    onTap: controller.downloadQr,
                  ),
                  _ActionButton(
                    icon: Icons.share,
                    label: 'Share',
                    onTap: controller.shareQr,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: AppColors.background,
        size: 25.r,
      ),
      label: Text(
        label,
        style: TextStyle(color: AppColors.background, fontSize: 16.sp),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.statusprimary,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
