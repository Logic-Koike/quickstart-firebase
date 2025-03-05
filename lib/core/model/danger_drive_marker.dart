import 'package:flutter_map/flutter_map.dart';

class DangerDriveMarker extends Marker {
  final int dangerLevel;
  final String markerId;

  const DangerDriveMarker(
      {required super.point,
      required super.child,
      required this.dangerLevel,
      required this.markerId});
}
