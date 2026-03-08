import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/extensions/form_auth_scroll.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class BaseFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final apiStatus = ApiStatus.idle.obs;
  ApiException? lastException;

  bool validate() => formKey.validateAndScroll();

  void resetApiState() {
    apiStatus.value = ApiStatus.idle;
    lastException = null;
  }
}