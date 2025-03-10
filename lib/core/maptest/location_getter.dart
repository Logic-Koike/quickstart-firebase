import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LocationGetter {
  static Future<List<Marker>> getLocations(String uid) async {
    if (FirebaseAuth.instance.currentUser == null) {
      return Future.value([]);
    }

    final snapshot = await FirebaseFirestore.instance
        .collection("locations")
        .doc(uid)
        .collection("placed_coordinates")
        .get();

    final data = snapshot.docs;

    final ret = data.map((doc) {
      final data = doc.data();
      return Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(data["latitude"], data["longitude"]),
        child: Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      );
    }).toList();

    return ret;

    //   .then((snapshot) {
    // return snapshot.docs.map((doc) {
    //   final data = doc.data();

    // return Marker(
    //   width: 40.0,
    //   height: 40.0,
    //   point: LatLng(data["latitude"], data["longitude"]),
    //   builder: (ctx) => Icon(
    //     Icons.location_on,
    //     color: Colors.red,
    //   ),
    // );
    // }).toList();
    // });
  }
}
