import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationService {
  static const String isolateName = 'LocatorIsolate';

  // 位置情報コールバック
  static void callback(LocationDto locationDto) async {
    print('位置情報更新: ${locationDto.latitude}, ${locationDto.longitude}');
    await sendLocationToServer(locationDto.latitude, locationDto.longitude);
  }

  // サーバーに送信
  static Future<void> sendLocationToServer(double lat, double lon) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection("tracking_locations")
          .doc(uid)
          .collection("coordinates")
          .doc()
          .set({
        'latitude': lat,
        'longitude': lon,
        'timestamp': DateTime.now(),
      });

      print('位置情報を送信しました');
    } catch (e) {
      print('送信エラー: $e');
    }
  }

  // ロケーショントラッキングの開始
  static Future<void> startLocationService() async {
    await BackgroundLocator.initialize();
    const androidSettings = AndroidSettings(
      interval: 30, // Androidでの更新間隔（秒）
      distanceFilter: 0,
      androidNotificationSettings: AndroidNotificationSettings(
        notificationTitle: '位置情報追跡中',
        notificationMsg: 'アプリがバックグラウンドで位置情報を取得しています',
        notificationChannelName: 'Location Tracking',
      ),
    );

    const iosSettings = IOSSettings(
      accuracy: LocationAccuracy.NAVIGATION,
      distanceFilter: 0, // iOSではdistanceFilterで調整
    );

    await BackgroundLocator.registerLocationUpdate(
      callback,
      autoStop: false,
      androidSettings: androidSettings,
      iosSettings: iosSettings,
    );
  }

  // ロケーショントラッキングの停止
  static Future<void> stopLocationService() async {
    await BackgroundLocator.unRegisterLocationUpdate();
  }
}
