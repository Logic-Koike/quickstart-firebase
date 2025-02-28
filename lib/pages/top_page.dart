import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickstart_firebase/components/list_data.dart';
import 'package:quickstart_firebase/components/user_info_display.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Future<void> _signout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Column(children: [
                  UserInfoDisplay(),
                  ElevatedButton(
                      onPressed: () async {
                        await _signout();
                      },
                      child: Text("Sign Out")),
                  ListData(),
                ]),
              ],
            )));
  }
}
