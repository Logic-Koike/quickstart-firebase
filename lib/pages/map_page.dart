import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:quickstart_firebase/core/maptest/marker_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final initialPos = LatLng(34.702485, 135.495951);
  final PopupController _popupController = PopupController();
  late final List<Marker> markers;

  @override
  void initState() {
    markers = TestMarkers.getTestMakers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        // child: Placeholder(child: Text("Map Page")),
        child: PopupScope(
      popupController: _popupController,
      child: FlutterMap(
          options: MapOptions(
            initialCenter: initialPos, // Center the map over London
            initialZoom: 10,
          ),
          children: [
            TileLayer(
              // Bring your own tiles
              urlTemplate:
                  // 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
                  "https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png",
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
    ));
  }
}
