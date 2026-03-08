import 'package:eventsmanager/core/constants/app_image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../api/api_status.dart';
import '../api/api_exceptions.dart';
import '../api/api_error_handler.dart';

class ApiErrorHandlingView extends StatefulWidget {
  final ApiStatus status;
  final Widget child;
  final ApiException? exception;

  const ApiErrorHandlingView({
    super.key,
    required this.status,
    required this.child,
    this.exception,
  });

  @override
  State<ApiErrorHandlingView> createState() => _ApiErrorHandlingViewState();
}

class _ApiErrorHandlingViewState extends State<ApiErrorHandlingView> {
  ApiStatus? _lastStatus;

  @override
  void didUpdateWidget(ApiErrorHandlingView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if status changed to an error state
    if (widget.status != oldWidget.status) {
      _handleStatusChange();
    }
  }

  void _handleStatusChange() {
    // Close any existing dialog first
    if (Get.isDialogOpen == true) {
      Get.back();
    }

    // Show error dialog for error states
    if (widget.status != ApiStatus.idle &&
        widget.status != ApiStatus.success &&
        widget.status != ApiStatus.loading) {
      _showErrorDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showErrorDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final errorConfig = _getErrorConfig(widget.status);

      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lottie Animation
                Lottie.asset(
                  errorConfig.lottie,
                  width: 150.w,
                  height: 150.h,
                  repeat: true,
                ),
                SizedBox(height: 16.h),

                // Error Message
                Text(
                  errorConfig.message,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 24.h),

                // OK Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
    });
  }

  _ErrorConfig _getErrorConfig(ApiStatus status) {
    switch (status) {
      case ApiStatus.offline:
        return const _ErrorConfig(
          lottie: AppImageAsset.offline,
          message: 'No internet connection',
        );

      case ApiStatus.timeout:
        return const _ErrorConfig(
          lottie: AppImageAsset.timeout,
          message: 'Request timeout, please try again',
        );

      case ApiStatus.serverError:
        return const _ErrorConfig(
          lottie: AppImageAsset.serverError,
          message: 'Server error, please try again later',
        );

      case ApiStatus.unauthorized:
        return const _ErrorConfig(
          lottie: AppImageAsset.unauthorized,
          message: 'Session expired, please login again',
        );

      case ApiStatus.forbidden:
        return const _ErrorConfig(
          lottie: AppImageAsset.forbidden,
          message: 'You do not have permission to access this',
        );

      case ApiStatus.notFound:
        return const _ErrorConfig(
          lottie: AppImageAsset.notfound,
          message: 'Requested resource not found',
        );

      case ApiStatus.validation:
      case ApiStatus.error:
        return _ErrorConfig(
          lottie: AppImageAsset.error,
          message: widget.exception != null
              ? ApiErrorHandler.getUserFriendlyMessage(widget.exception!)
              : 'Something went wrong',
        );

      default:
        return const _ErrorConfig(
          lottie: AppImageAsset.error,
          message: 'Something went wrong',
        );
    }
  }
}

// ==================== Error Config ====================

class _ErrorConfig {
  final String lottie;
  final String message;

  const _ErrorConfig({
    required this.lottie,
    required this.message,
  });
}
