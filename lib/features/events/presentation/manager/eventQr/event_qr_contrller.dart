import 'dart:io';
import 'dart:ui' as ui;

import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class EventQrController extends GetxController {
  late String data;
  final GlobalKey qrKey = GlobalKey();
  late EventModel eventModel;
  @override
  void onInit() {
    eventModel = Get.arguments["eventModel"];
    data = eventModel.attendanceCode!;
    super.onInit();
  }

  /// Generate PNG bytes from QR widget
  Future<Uint8List> _generateQrBytes() async {
    final boundary =
        qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  /// Share QR
  Future<void> shareQr() async {
    if (kIsWeb) {
      Get.snackbar('Not supported', 'Sharing is not available on web');
      return;
    }

    try {
      final bytes = await _generateQrBytes();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/qr_code.png');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Scan this QR code',
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  /// Save QR to Gallery / Photos
  Future<void> downloadQr() async {
    try {
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          Get.snackbar('Permission denied', 'Storage permission required');
          return;
        }
      }

      final bytes = await _generateQrBytes();
      final result = await ImageGallerySaverPlus.saveImage(
        bytes,
        name: 'qr_${DateTime.now().millisecondsSinceEpoch}',
        quality: 100,
      );

      if (result['isSuccess'] == true) {
        Get.snackbar('Saved', 'QR code saved to gallery');
      } else {
        Get.snackbar('Error', 'Failed to save QR code');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
