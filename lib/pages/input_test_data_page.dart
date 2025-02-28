import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickstart_firebase/components/user_info_display.dart';

class InputTestDataPage extends StatefulWidget {
  const InputTestDataPage({super.key});

  @override
  State<InputTestDataPage> createState() => _InputTestDataPageState();
}

class _InputTestDataPageState extends State<InputTestDataPage> {
  String content = '';

  Future<void> _register() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    String customId = "${uid}_${DateTime.now().millisecondsSinceEpoch}";

    // ここにデータ登録処理を書く
    await FirebaseFirestore.instance.collection("test").doc(customId).set({
      "uid": uid,
      "content": content,
      "created_at": FieldValue.serverTimestamp(),
      "updated_at": FieldValue.serverTimestamp(),
      "tags": ["test1", "test2"]
    });

    print(content);
    if (mounted) {
      SnackBar snackBar = SnackBar(content: Text('データ登録に成功しました'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ログインチェック
    // 未ログインの場合はログインページに遷移
    if (FirebaseAuth.instance.currentUser == null) {
      // ログインしていない
      return Center(child: Text("ログインしていません。まずログインしてください。"));
    }
    return Center(
        child: Padding(
            padding: EdgeInsets.all(30),
            child: ListView(
              children: [
                UserInfoDisplay(),
                Text("データを入力してください"),
                TextField(
                  decoration: InputDecoration(labelText: "テストデータ"),
                  onChanged: (value) {
                    content = value;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      await _register();
                    },
                    child: Text('登録')),
              ],
            )));
  }
}
