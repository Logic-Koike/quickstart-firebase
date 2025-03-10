import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:quickstart_firebase/core/maptest/location_getter.dart';
import 'package:quickstart_firebase/core/maptest/location_sender.dart';
import 'package:quickstart_firebase/core/maptest/marker_widget.dart';
import 'package:quickstart_firebase/core/model/danger_drive_marker.dart';
import 'package:quickstart_firebase/pages/login_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  final initialPos = LatLng(34.702485, 135.495951);
  final PopupController _popupController = PopupController();
  late List<Marker> initialMarkers = [];
  late final _animatedMapController = AnimatedMapController(vsync: this);

  var isInitialized = false;
  var placedMarkers = <Marker>[];
  var _centerPosition = LatLng(0, 0);

  static const _useTransformerId = 'useTransformerId';
  final _useTransformar = true;

  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    // マップが移動した時
    setState(() {
      _centerPosition = camera.center;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    initialMarkers = await LocationGetter.getLocations(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
          // child: Placeholder(child: Text("Map Page")),
          children: [
            PopupScope(
              popupController: _popupController,
              child: FlutterMap(
                  mapController: _animatedMapController.mapController,
                  options: MapOptions(
                      initialCenter: initialPos, // Center the map over London
                      initialZoom: 10,
                      interactionOptions: InteractionOptions(
                          enableMultiFingerGestureRace: true,
                          flags: InteractiveFlag.drag |
                              InteractiveFlag.pinchZoom |
                              InteractiveFlag.scrollWheelZoom),
                      onMapReady: () {
                        // ログインしているかどうかを確認
                        if (FirebaseAuth.instance.currentUser == null) {
                          // ログインしていない場合、モーダルを表示
                          showModalBottomSheet(
                              context: context,
                              enableDrag: false,
                              isDismissible: false,
                              builder: (context) {
                                return LoginPage(redirectPath: "");
                              });
                          // Navigator.pushNamed(context, '/login');
                        }
                      },
                      onPositionChanged: _onPositionChanged),
                  children: [
                    TileLayer(
                      urlTemplate:
                          //  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          "https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png",
                      // "https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png",
                      userAgentPackageName:
                          'com.logic.exampleapp', // Add your app identifier
                      tileProvider: NetworkTileProvider(
                        headers: {
                          "Access-Control-Allow-Origin": "*",
                        },
                      ),
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
                          markers: initialMarkers,
                          onClusterTap: (cluster) {
                            _popupController.hideAllPopups();
                          },
                          popupOptions: PopupOptions(
                              popupController: _popupController,
                              popupBuilder: (context, marker) {
                                // 実データにキャスト
                                final dangerDriveMarker =
                                    marker as DangerDriveMarker;

                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.blue),
                                    color: Colors.white,
                                  ),
                                  width: 200,
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ポップアップ表示",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            "緯度 ${dangerDriveMarker.point.latitude}"),
                                        Text(
                                            "経度 ${dangerDriveMarker.point.longitude}"),
                                        Text(
                                            "危険運転種別 ${dangerDriveMarker.dangerLevel}"),
                                        Text(
                                          "ID : ${dangerDriveMarker.markerId}",
                                        )
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
                    ),
                    MarkerLayer(markers: placedMarkers),
                  ]),
            ),
            Center(
                child: Icon(Icons.location_pin, color: Colors.red, size: 40.0))
          ]),
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
          const SizedBox(height: 10),
          FloatingActionButton(
              onPressed: () async {
                setState(() {
                  placedMarkers.add(Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _centerPosition,
                      child: Icon(Icons.location_on, color: Colors.blue)));
                });
                await LocationSender.sendLocation("placed_coordinates",
                    FirebaseAuth.instance.currentUser!.uid, _centerPosition);
              },
              tooltip: "この地点を追加",
              child: Icon(Icons.add_location_alt,
                  color: Colors.orangeAccent.shade700)),
        ],
      ),
    );
  }
}
