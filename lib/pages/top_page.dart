import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickstart_firebase/components/user_info_display.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  String firebaseAuthStatus = "";

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       setState(() {
  //         firebaseAuthStatus = "Not signed in";
  //       });
  //     } else {
  //       setState(() {
  //         firebaseAuthStatus = "Signed in: ${user.email}";
  //       });
  //     }
  //   });
  // }

  Future<void> _signout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(30),
            child: ListView(children: [
              UserInfoDisplay(),
              ElevatedButton(
                  onPressed: () async {
                    await _signout();
                  },
                  child: Text("Sign Out")),
            ])));
  }
}
