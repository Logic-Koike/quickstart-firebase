import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  Future<void> _signup() async {
    // ここにサインアップ処理を書く
    var firebase = FirebaseAuth.instance;
    var cred = await firebase.createUserWithEmailAndPassword(
        email: email, password: password);
    print(cred);
    if (mounted) {
      SnackBar snackBar = SnackBar(content: Text('サインアップに成功しました'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pushNamed("/top");
    }
  }

  Future<void> _signin() async {
    // ここにサインイン処理を書く
    var firebase = FirebaseAuth.instance;
    var cred = await firebase.signInWithEmailAndPassword(
        email: email, password: password);
    print(cred);
    if (mounted) {
      SnackBar snackBar = SnackBar(content: Text('サインインに成功しました'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pushNamed("/top");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(30),
            child: ListView(
              children: [
                Text('Login Page'),
                TextField(
                  decoration: InputDecoration(labelText: "メールアドレス"),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: "パスワード"),
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await _signup();
                    },
                    child: Text('Sign Up')),
                ElevatedButton(
                    onPressed: () async {
                      await _signin();
                    },
                    child: Text('Sign In')),
                ElevatedButton(
                    onPressed: () async {
                      // fetch test API
                      var url = Uri.parse(
                          'https://jsonplaceholder.typicode.com/posts/1');
                      var response = await http.get(url);
                      print(response);
                    },
                    child: Text('Fetch Test API')),
              ],
            )));
  }
}
