import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  const ListData({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return Center(child: Text("ログインしていません。まずログインしてください。"));
    }

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (authSnapshot.hasError) {
            return Text("Error: ${authSnapshot.error}");
          }

          User? user = authSnapshot.data;
          if (user == null) {
            return Text("サインインしてください。");
          }

          if (authSnapshot.data == null) {
            return Text("No data");
          }

          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("test")
                  .where("uid", isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                if (!snapshot.hasData) {
                  return Text("No data");
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Text("登録データがありません。");
                }

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data!.docs[index]["content"]),
                        onTap: () {},
                      );
                    });
              });
        });

    // return StreamBuilder(
    //     stream: FirebaseFirestore.instance
    //         .collection("test")
    //         .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //         .snapshots(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return CircularProgressIndicator();
    //       }
    //       if (snapshot.hasError) {
    //         return Text("Error: ${snapshot.error}");
    //       }
    //       if (!snapshot.hasData) {
    //         return Text("No data");
    //       }
    //       return ListView.builder(
    //           shrinkWrap: true,
    //           itemCount: snapshot.data!.docs.length,
    //           itemBuilder: (context, index) {
    //             return ListTile(
    //               title: Text(snapshot.data!.docs[index]["content"]),
    //               onTap: () {},
    //             );
    //           });
    //     });
  }
}
