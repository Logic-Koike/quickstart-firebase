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
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('位置情報取得の切り替え', style: Theme.of(context).textTheme.headlineLarge),
          Text("「トラッキング開始」ボタンを押すとバックグラウンドで位置情報を取得します。"),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await LocationService.startLocationService();
                  const snackBar = SnackBar(content: Text('トラッキングを開始しました'));
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                icon: Icon(Icons.location_searching),
                label: Text('トラッキング開始'),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton.icon(
                onPressed: () async {
                  await LocationService.stopLocationService();
                  const snackBar = SnackBar(content: Text('トラッキングを停止しました'));
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                icon: Icon(Icons.location_disabled),
                label: Text('トラッキング停止'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
