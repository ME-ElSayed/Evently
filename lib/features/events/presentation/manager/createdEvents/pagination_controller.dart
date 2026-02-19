import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class PaginationController<T> extends GetxController {
  // UI
  late final ScrollController scrollController;

  // State
  final RxList<T> items = <T>[].obs;
  final isInitialLoading = true.obs;
  final isPaginationLoading = false.obs;
  final hasMore = true.obs;

  // Pagination config
  int page = 1;
  final int limit;

  // Internal lock
  bool _isFetching = false;

  PaginationController({this.limit = 10});

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_onScroll);
    fetchInitial();
  }

  void _onScroll() {
    if (!hasMore.value || isPaginationLoading.value || _isFetching) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      fetchMore();
    }
  }

  /// Must be implemented by subclasses
  Future<List<T>> fetchPage(int page, int limit);

  /// Initial load / refresh
  Future<void> fetchInitial() async {
    if (_isFetching) return;

    _lock();
    isInitialLoading.value = true;
    hasMore.value = true;
    page = 1;
    items.clear();

    await _fetch();

    isInitialLoading.value = false;
    _unlock();
  }

  /// Pagination load
  Future<void> fetchMore() async {
    if (!hasMore.value || isPaginationLoading.value || _isFetching) return;

    _lock();
    isPaginationLoading.value = true;

    await _fetch();

    isPaginationLoading.value = false;
    _unlock();
  }

  Future<void> _fetch() async {
    final data = await fetchPage(page, limit);

    if (data.isEmpty || data.length < limit) {
      hasMore.value = false;
    }

    items.addAll(data);
    page++;
  }

  void retry() {
    items.isEmpty ? fetchInitial() : fetchMore();
  }

  void _lock() => _isFetching = true;
  void _unlock() => _isFetching = false;

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
}