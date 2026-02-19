import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

/// ================= MODELS =================

class EventAddress {
  final String governorate;
  final String fullAddress;
  final String countryCode;

  EventAddress({
    required this.governorate,
    required this.fullAddress,
    required this.countryCode,
  });
}

class SearchPlace {
  final String name;
  final String address;
  final LatLng location;

  SearchPlace({
    required this.name,
    required this.address,
    required this.location,
  });
}

/// ================= CONTROLLER =================

class EventMapController extends GetxController {
  final mapController = MapController();
  final Location location = Location();
  final Dio dio = Dio();

  /// EVENT (SOURCE OF TRUTH)
  final eventLocation = Rxn<LatLng>();
  final eventAddress = Rxn<EventAddress>();
  final eventMarker = Rxn<Marker>();

  /// SEARCH
  final searchResults = <SearchPlace>[].obs;

  /// GPS COUNTRY (FOR SEARCH BEFORE SELECTION)
  final gpsCountryCode = RxnString();
  static const LatLng egypt = LatLng(30.0444, 31.2357);

  @override
  void onInit() {
    super.onInit();
    setEventLocation(egypt);
    _initGps();
  }

  // ================= GPS INIT (CAMERA + COUNTRY) =================

  Future<void> _initGps() async {
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) return;
    }

    if (await location.hasPermission() == PermissionStatus.denied) {
      if (await location.requestPermission() != PermissionStatus.granted) return;
    }

    final loc = await location.getLocation();
    final point = LatLng(loc.latitude!, loc.longitude!);

    mapController.move(point, 14);
    await _fetchGpsCountry(point);
  }

  Future<void> _fetchGpsCountry(LatLng point) async {
    try {
      final response = await dio.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'lat': point.latitude,
          'lon': point.longitude,
          'format': 'json',
        },
        options: Options(headers: {
          'User-Agent': 'event-app',
        }),
      );

      gpsCountryCode.value =
          response.data['address']?['country_code'];
    } catch (_) {}
  }

  // ================= EVENT LOCATION =================

  void setEventLocation(LatLng point) {
    eventLocation.value = point;

    eventMarker.value = Marker(
      width: 50,
      height: 50,
      point: point,
      child: const Icon(
        Icons.location_on,
        color: Colors.red,
        size: 40,
      ),
    );

    fetchEventAddress(point);
  }

  // ================= REVERSE GEOCODING =================

  Future<void> fetchEventAddress(LatLng point) async {
    try {
      final response = await dio.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'lat': point.latitude,
          'lon': point.longitude,
          'format': 'json',
          'accept-language': 'en',
        },
        options: Options(headers: {
          'User-Agent': 'event-app',
        }),
      );

      final address = response.data['address'];

      eventAddress.value = EventAddress(
        governorate:
            address['state'] ?? address['county'] ?? 'Unknown',
        fullAddress: response.data['display_name'],
        countryCode:
            (address['country_code'] ?? '').toString(),
      );
    } catch (_) {}
  }

  // ================= SEARCH (FIXED) =================

  Future<void> searchPlace(String query) async {
    if (query.trim().length < 3) return;

    /// 🔑 USE EVENT COUNTRY IF EXISTS, ELSE GPS COUNTRY
    final countryCode =
        eventAddress.value?.countryCode ??
        gpsCountryCode.value;

    if (countryCode == null || countryCode.isEmpty) return;

    try {
      final response = await dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': query,
          'format': 'jsonv2',
          'limit': 8,
          'accept-language': 'en',
          'addressdetails': 1,
          'countrycodes': countryCode,
        },
        options: Options(headers: {
          'User-Agent': 'event-app',
        }),
      );

      searchResults.assignAll(
        (response.data as List).map((e) {
          return SearchPlace(
            name: e['name'] ??
                e['display_name'].split(',').first,
            address: e['display_name'],
            location: LatLng(
              double.parse(e['lat']),
              double.parse(e['lon']),
            ),
          );
        }),
      );
    } catch (e) {
      debugPrint('Search error: $e');
    }
  }

  // ================= SEARCH SELECT =================

  void selectSearchResult(SearchPlace place) {
    setEventLocation(place.location);
    mapController.move(place.location, 15);
    searchResults.clear();
  }
}
