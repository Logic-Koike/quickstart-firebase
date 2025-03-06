import 'package:flutter/material.dart';
import 'package:quickstart_firebase/core/maptest/location_service.dart';

class ToggleTracingPage extends StatefulWidget {
  const ToggleTracingPage({super.key});

  @override
  State<ToggleTracingPage> createState() => _ToggleTracingPageState();
}

class _ToggleTracingPageState extends State<ToggleTracingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('バックグラウンド位置情報')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: LocationService.startLocationService,
                child: Text('トラッキング開始'),
              ),
              ElevatedButton(
                onPressed: LocationService.stopLocationService,
                child: Text('トラッキング停止'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
