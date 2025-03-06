import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:quickstart_firebase/core/maptest/marker_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  final initialPos = LatLng(34.702485, 135.495951);
  final PopupController _popupController = PopupController();
  late final List<Marker> markers;
  late final _animatedMapController = AnimatedMapController(vsync: this);

  static const _useTransformerId = 'useTransformerId';
  final _useTransformar = true;

  @override
  void initState() {
    markers = TestMarkers.getTestMakers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          // child: Placeholder(child: Text("Map Page")),
          child: PopupScope(
        popupController: _popupController,
        child: FlutterMap(
            mapController: _animatedMapController.mapController,
            options: MapOptions(
                initialCenter: initialPos, // Center the map over London
                initialZoom: 10,
                interactionOptions: InteractionOptions(
                    enableMultiFingerGestureRace: true,
                    flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom)),
            children: [
              TileLayer(
                urlTemplate:
                    //  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    "https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png",
                // "https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png",
                userAgentPackageName:
                    'com.logic.exampleapp', // Add your app identifier
              ),
              RichAttributionWidget(attributions: [
                TextSourceAttribution(
                  "国土地理院\nhttps://maps.gsi.go.jp/development/ichiran.html",
                )
              ]),
              MarkerClusterLayerWidget(
                options: MarkerClusterLayerOptions(
                    maxClusterRadius: TestMarkers.maxClusterRadius,
                    size: const Size(40, 40),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(50),
                    maxZoom: 15,
                    markers: markers,
                    onClusterTap: (cluster) {
                      _popupController.hideAllPopups();
                    },
                    popupOptions: PopupOptions(
                        popupController: _popupController,
                        popupBuilder: (context, marker) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.blue),
                              color: Colors.white,
                            ),
                            width: 200,
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ポップアップ表示",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("緯度 ${marker.point.latitude}"),
                                  Text("経度 ${marker.point.longitude}"),
                                ],
                              ),
                            ),
                          );
                        }),
                    builder: (context, markers) {
                      // クラスターの表示
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        child: Center(
                          child: Text(
                            markers.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
              )
            ]),
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _animatedMapController.animatedZoomOut(
              customId: _useTransformar ? _useTransformerId : null,
            ),
            tooltip: 'Zoom out',
            child: const Icon(Icons.zoom_out),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _animatedMapController.animatedZoomIn(
              customId: _useTransformar ? _useTransformerId : null,
            ),
            tooltip: 'Zoom in',
            child: const Icon(Icons.zoom_in),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
              onPressed: () => {
                    _animatedMapController.animateTo(
                      dest: initialPos,
                      duration: const Duration(seconds: 1),
                      zoom: 12,
                    )
                  },
              tooltip: "Osaka Station",
              child: const Icon(Icons.location_on)),
        ],
      ),
    );
  }
}
