import 'package:flutter/material.dart';

class TextFormBorders {
  // キーボード表示時のフォームの枠線。
  static const textFormFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Colors.deepPurple,
      width: 2,
    ),
  );

  // 平常時のフォームの枠線。
  static const textFormEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );

  // 入力中のエラー時の枠線。
  static const textFormErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Colors.red,
      width: 2,
    ),
  );
}
