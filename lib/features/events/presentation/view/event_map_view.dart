import 'package:eventsmanager/features/events/data/models/event_location_result.dart';
import 'package:eventsmanager/features/events/presentation/manager/eventMap/event_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class EventMapView extends GetView<EventMapController> {
  EventMapView({super.key});

  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Event Location'),
        actions: [
          Obx(() {
            final address = controller.eventAddress.value;
            final position = controller.eventLocation.value;
            final enabled = address != null && position != null;

            return IconButton(
              icon: const Icon(Icons.check),
              tooltip: enabled ? 'Confirm location' : 'Pick a location first',
              onPressed: enabled
                  ? () {
                      Get.back(
                        result: EventLocationResult(
                          governorate: address.governorate,
                          fullAddress: address.fullAddress,
                          position: position,
                        ),
                      );
                    }
                  : null,
            );
          }),
        ],
      ),

      /// ================= BODY =================
      body: Stack(
        children: [
          /// ================= MAP + ADDRESS =================
          Column(
            children: [
              const SizedBox(height: 72), // space for search overlay

              /// 🗺 MAP
              Expanded(
                child: FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(
                    initialCenter: EventMapController.egypt,
                    initialZoom: 6,
                    onTap: (_, LatLng point) {
                      FocusScope.of(context).unfocus();
                      controller.setEventLocation(point);
                    },
                  ),
                  children: [
                    /// ✅ SAFE TILE PROVIDER (NO BLOCKING)
                    TileLayer(
                      urlTemplate:
                          'https://basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                      maxZoom: 19,
                    ),

                    /// ✅ REQUIRED ATTRIBUTION
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          '© OpenStreetMap contributors © CARTO',
                        ),
                      ],
                    ),

                    /// 📍 MARKER
                    Obx(() {
                      final marker = controller.eventMarker.value;
                      if (marker == null) return const SizedBox();
                      return MarkerLayer(markers: [marker]);
                    }),
                  ],
                ),
              ),

              /// 📍 ADDRESS PANEL
              _AddressPanel(controller),
            ],
          ),

          /// ================= SEARCH OVERLAY =================
          _SearchOverlay(controller, searchCtrl),
        ],
      ),
    );
  }
}

/// ================= SEARCH OVERLAY =================

class _SearchOverlay extends StatelessWidget {
  final EventMapController controller;
  final TextEditingController searchCtrl;

  const _SearchOverlay(this.controller, this.searchCtrl);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Positioned(
      top: 12,
      left: 12,
      right: 12,
      child: Column(
        children: [
          /// SEARCH FIELD
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search location',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: controller.searchPlace,
            ),
          ),

          /// SEARCH RESULTS (KEYBOARD SAFE)
          Obx(() {
            if (controller.searchResults.isEmpty) {
              return const SizedBox();
            }

            return Container(
              margin: const EdgeInsets.only(top: 8),
              constraints: BoxConstraints(
                maxHeight:
                    MediaQuery.of(context).size.height * 0.4 - bottomInset,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.searchResults.length,
                itemBuilder: (_, index) {
                  final place = controller.searchResults[index];
                  return ListTile(
                    title: Text(place.name),
                    subtitle: Text(
                      place.address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      searchCtrl.clear();
                      controller.selectSearchResult(place);
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// ================= ADDRESS PANEL =================

class _AddressPanel extends StatelessWidget {
  final EventMapController controller;
  const _AddressPanel(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final address = controller.eventAddress.value;
      if (address == null) return const SizedBox();

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              address.governorate,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              address.fullAddress,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      );
    });
  }
}
