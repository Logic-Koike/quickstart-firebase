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
                  maxClusterRadius: 45,
                  size: const Size(40, 40),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(50),
                  maxZoom: 15,
                  markers: markers,
                  onMarkerTap: (marker) {
                    final snackBar = SnackBar(content: Text('Tap $initialPos'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  builder: (context, markers) {
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
            // MarkerLayer(
            //   markers: [
            //     Marker(
            //       point: initialPos,
            //       width: double.infinity,
            //       height: double.infinity,
            //       child: GestureDetector(
            //         child: Center(
            //           child: Icon(
            //             Icons.location_on,
            //             color: Colors.blue,
            //             size: 40.0,
            //           ),
            //         ),
            //         onTap: () {
            //           final snackBar =
            //               SnackBar(content: Text('Tap $initialPos'));
            //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //         },
            //       ),
            //     ),
            //     Marker(
            //       point: initialPos,
            //       child: Icon(
            //         Icons.circle,
            //         size: 1,
            //         color: Colors.red,
            //       ),
            //     ),
            //   ],
            // ),
          ]),
    );
  }
}
