import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final initialPos = LatLng(34.702485, 135.495951);

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

              // And many more recommended properties!
            ),
            RichAttributionWidget(attributions: [
              TextSourceAttribution(
                "国土地理院\nhttps://maps.gsi.go.jp/development/ichiran.html",
              )
            ]),
            // SimpleAttributionWidget(
            //   source: Text('マップ表示テスト'),
            // ),
            MarkerLayer(
              markers: [
                Marker(
                    point: initialPos,
                    child: GestureDetector(
                      child: Icon(
                        Icons.gps_fixed,
                        size: 60,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        final snackBar =
                            SnackBar(content: Text('Tap $initialPos'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    alignment: Alignment.topLeft),
                Marker(
                  point: initialPos,
                  child: Icon(
                    Icons.circle,
                    size: 1,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
