import 'package:eventsmanager/core/api/api_exceptions.dart';
import 'package:eventsmanager/core/api/api_status.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';
import 'package:eventsmanager/features/events/data/models/event_model.dart';
import 'package:eventsmanager/features/events/data/repo/event_repo.dart';
import 'package:eventsmanager/features/events/presentation/manager/createdEvents/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchEventControllerImp extends PaginationController<EventModel> {
  final EventRepository _eventRepository = Get.find<EventRepository>();
  final SharedprefService _sharedPrefService = Get.find<SharedprefService>();

  late TextEditingController searchTextController;

  // API State
  final apiStatus = ApiStatus.idle.obs;
  ApiException? lastException;

  // Filters
  final RxnBool priceDown = RxnBool();
  final RxnBool priceUp = RxnBool();
  final RxnString selectedGovernment = RxnString();
  final RxString searchQuery = ''.obs;

  // UI State
  final RxInt notificationCount = 6.obs;

  SearchEventControllerImp({super.limit = 10});

  @override
  void onInit() {
    _initGovernorate();
    searchTextController = TextEditingController();

    // Governorate change → refresh
    ever(selectedGovernment, (_) => _refreshIfIdle());

    super.onInit(); // triggers fetchInitial()
  }

  void _initGovernorate() {
    final userData = _sharedPrefService.getUserData();
    selectedGovernment.value = userData?['governorate'];
  }

  /* ================= API ================= */

  @override
  Future<List<EventModel>> fetchPage(int page, int limit) async {
    apiStatus.value = ApiStatus.loading;
    lastException = null;

    final result = await _eventRepository.searchEvents(
      governorate: selectedGovernment.value?.isNotEmpty == true
          ? selectedGovernment.value
          : null,
      sort: _getSortValue(),
      name: searchQuery.value.isNotEmpty ? searchQuery.value : null,
      page: page,
      limit: limit,
    );

    return result.fold(
      (exception) {
        lastException = exception;
        apiStatus.value = ApiStatusMapper.fromException(exception);
        hasMore.value = false;
        return <EventModel>[];
      },
      (events) {
        apiStatus.value = ApiStatus.success;
        return events;
      },
    );
  }

  /* ================= SORT ================= */

  String _getSortValue() {
    if (priceDown.value == true) return 'price'; // ASC
    if (priceUp.value == true) return '-price'; // DESC
    return 'startAt'; // Default
  }

  void togglePriceDown() {
    if (priceDown.value == true) {
      clearPriceSort();
      return;
    }
    priceDown.value = true;
    priceUp.value = false;
    _refreshIfIdle();
  }

  void togglePriceUp() {
    if (priceUp.value == true) {
      clearPriceSort();
      return;
    }
    priceUp.value = true;
    priceDown.value = false;
    _refreshIfIdle();
  }

  void clearPriceSort() {
    priceDown.value = null;
    priceUp.value = null;
    _refreshIfIdle();
  }

  /* ================= SEARCH ================= */

  void onSearchSubmit(String query) {
    if (query.trim() == "") return;
    searchQuery.value = query.trim();
    fetchInitial();
  }

  /* ================= HELPERS ================= */

  void _refreshIfIdle() {
    if (!isInitialLoading.value && !isPaginationLoading.value) {
      fetchInitial();
    }
  }

  /* ================= UI ================= */

  void resetFilters() {
    //_initGovernorate();
    selectedGovernment.value = null;
    priceDown.value = null;
    priceUp.value = null;
    searchQuery.value = '';
    searchTextController.clear();
    fetchInitial();
  }

  Future<void> refreshEvents() => fetchInitial();

  void goTop() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
