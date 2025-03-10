import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class LocationSender {
  static Future<void> sendLocation(
      String collectionName, String uid, LatLng location) async {
    // Send location to server

    await FirebaseFirestore.instance
        .collection("locations")
        .doc(uid)
        .collection(collectionName)
        .doc()
        .set({
      "uid": uid,
      "latitude": location.latitude,
      "longitude": location.longitude,
      "created_at": FieldValue.serverTimestamp(),
    });

    print(
        "Send location to server: $uid, ${location.latitude}, ${location.longitude}");
  }
}
