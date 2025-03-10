# quickstart_firebase

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## 開発環境の設定

1. Google Cloud Consoleでプロジェクト作成
2. Firebase Authenticationの設定
3. firebase CLIをインストール
4. `firebase login`でログイン
5. `dart pub global activate flutterfire_cli`を実行
6. プロジェクトディレクトリで`flutterfire configure --project=fir-test-3d89d`を実行
    - プロジェクトごとにIDは異なる


## Azureデプロイ

1. Azure CLIのインストール : `winget install --exact --id Microsoft.AzureCLI`
2. Azure ログイン：`az login`
3. `terraform init`
4. `terraform plan`
5. `terraform apply`

## Firebaseエミュレータ


1. firebase CLIのインストール
2. プロジェクトディレクトリで`firebase init`
3. `firebase emulators:start`
4. `main()`の中でエミュレータを利用するように設定

``` dart
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Firebase Emulatorの利用
  FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
  await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
```

バックグラウンド位置情報取得
https://github.com/Yukams/background_locator_fixed/wiki/Setup#android
