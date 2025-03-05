import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TestMarkers {
  static const osakaStation = LatLng(34.702485, 135.495951);
  static const maxClusterRadius = 100;

  static List<Marker> getTestMakers() {
    var markers = <Marker>[];

    final totalMarkers = 3000;

    final minLatitude = 34.5;
    final maxLatitude = 35.0;
    final minLongitude = 135.0;
    final maxLongitude = 135.6;

    // 同一地点
    for (var i = 0; i < 30; i++) {
      markers.add(Marker(
        point: osakaStation,
        child: const Icon(Icons.error),
      ));
    }

    for (var i = 0; i < totalMarkers; i++) {
      final latitude =
          minLatitude + Random().nextDouble() * (maxLatitude - minLatitude);
      final longitude =
          minLongitude + Random().nextDouble() * (maxLongitude - minLongitude);

      markers.add(Marker(
        point: LatLng(latitude, longitude),
        child: const Icon(
          Icons.pin_drop,
          color: Colors.orange,
        ),
      ));
    }

    // final totalMarkers = 2000.0;
    // final minLatLng = const LatLng(49.8566, 1.3522);
    // final maxLatLng = const LatLng(58.3498, -10.2603);

    // final latitudeRange = maxLatLng.latitude - minLatLng.latitude;
    // final longitudeRange = maxLatLng.longitude - minLatLng.longitude;

    // final stepsInEachDirection = sqrt(totalMarkers).floor();
    // final latStep = latitudeRange / stepsInEachDirection;
    // final lonStep = longitudeRange / stepsInEachDirection;

    // for (var i = 0; i < stepsInEachDirection; i++) {
    //   for (var j = 0; j < stepsInEachDirection; j++) {
    //     final latLng = LatLng(
    //       minLatLng.latitude + i * latStep,
    //       minLatLng.longitude + j * lonStep,
    //     );

    //     markers.add(
    //       Marker(
    //         height: 30,
    //         width: 30,
    //         point: latLng,
    //         child: const Icon(Icons.pin_drop),
    //       ),
    //     );
    //   }
    // }

    return markers;
  }
}
