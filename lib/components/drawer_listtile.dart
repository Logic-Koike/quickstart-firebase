import 'package:flutter/material.dart';

Widget drawerListTile(
    {required BuildContext context,
    required String title,
    required String path}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, path);
              },
              icon: const Icon(Icons.arrow_circle_right),
            )
          ],
        ),
      ),
      const Divider(
        thickness: 1.0,
        color: Colors.black,
      ),
    ],
  );
}
