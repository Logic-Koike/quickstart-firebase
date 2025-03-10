import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.redirectPath = "/top"});

  final String redirectPath;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // フォームが有効な場合の処理
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('フォーム送信成功')),
      );
    }
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // ここにサインアップ処理を書く
    var firebase = FirebaseAuth.instance;
    var cred = await firebase.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
    print(cred);
    if (mounted) {
      SnackBar snackBar = SnackBar(content: Text('サインアップに成功しました'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pushNamed(widget.redirectPath);
    }
  }

  Future<void> _signin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // ここにサインイン処理を書く
    var firebase = FirebaseAuth.instance;
    var cred = await firebase.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
    print(cred);
    if (mounted) {
      SnackBar snackBar = SnackBar(content: Text('サインインに成功しました'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if (widget.redirectPath == "") {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pushNamed(widget.redirectPath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ログイン',
                      style: Theme.of(context).textTheme.headlineLarge),
                  Text("メールアドレスとパスワードを入力して、ログインもしくは新規登録を行ってください。"),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: "メールアドレス"),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'メールアドレスを入力してください';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return '有効なメールアドレスを入力してください';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: "パスワード"),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                      if (value.length < 8) {
                        return 'パスワードは8文字以上で入力してください';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                            onPressed: () async {
                              await _signup();
                            },
                            icon: const Icon(Icons.person_add, size: 30),
                            label: const Text(
                              '新規登録',
                            )),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                          child: ElevatedButton.icon(
                              onPressed: () async {
                                await _signin();
                              },
                              icon: const Icon(
                                Icons.login,
                              ),
                              label: Text('ログイン'))),
                    ],
                  )
                ],
              ),
            )));
  }
}
