import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoDisplay extends StatefulWidget {
  const UserInfoDisplay({super.key});

  @override
  State<UserInfoDisplay> createState() => _UserInfoDisplayState();
}

class _UserInfoDisplayState extends State<UserInfoDisplay> {
  String firebaseAuthStatus = "";

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          firebaseAuthStatus = "Not signed in";
        });
      } else {
        setState(() {
          firebaseAuthStatus = "Signed in: ${user.email} uid: ${user.uid} ";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(firebaseAuthStatus);
  }
}
