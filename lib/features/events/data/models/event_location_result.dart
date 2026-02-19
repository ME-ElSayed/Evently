import 'package:latlong2/latlong.dart';

class EventLocationResult {
  final String governorate;
  final String fullAddress;
  final LatLng position;

  EventLocationResult({
    required this.governorate,
    required this.fullAddress,
    required this.position,
  });
}
