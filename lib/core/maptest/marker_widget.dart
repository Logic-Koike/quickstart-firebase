import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:quickstart_firebase/core/model/danger_drive_marker.dart';

class TestMarkers {
  static const osakaStation = LatLng(34.702485, 135.495951);
  static const maxClusterRadius = 100;

  static List<DangerDriveMarker> getTestMakers() {
    var markers = <DangerDriveMarker>[];

    final totalMarkers = 3000;

    final minLatitude = 34.6;
    final maxLatitude = 34.8;
    final minLongitude = 135.3;
    final maxLongitude = 135.6;

    // 同一地点
    for (var i = 0; i < 30; i++) {
      markers.add(DangerDriveMarker(
        point: osakaStation,
        child: const Icon(Icons.error),
        dangerLevel: i % 3,
        markerId: 'osakaStation_$i',
      ));
    }

    for (var i = 0; i < totalMarkers; i++) {
      final latitude =
          minLatitude + Random().nextDouble() * (maxLatitude - minLatitude);
      final longitude =
          minLongitude + Random().nextDouble() * (maxLongitude - minLongitude);

      var widget = null;
      if (i % 3 == 0) {
        widget = Icon(Icons.error, color: Colors.red);
      } else if (i % 3 == 1) {
        widget = Icon(Icons.warning, color: Colors.yellow);
      } else {
        widget = Icon(Icons.info, color: Colors.blue);
      }

      markers.add(DangerDriveMarker(
        point: LatLng(latitude, longitude),
        child: widget,
        dangerLevel: i % 3,
        markerId: 'dangerdrive_$i',
      ));
    }

    return markers;
  }
}
