import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quickstart_firebase/components/text_form_borders.dart';
import 'package:quickstart_firebase/pages/input_test_data_page.dart';
import 'package:quickstart_firebase/pages/login_page.dart';
import 'package:quickstart_firebase/pages/toggle_tracing.dart';
import 'package:quickstart_firebase/pages/top_page.dart';
import 'firebase_options.dart';
import 'pages/map_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Firebase Emulatorの利用
  FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
  await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(16),
          focusedBorder: TextFormBorders.textFormFocusedBorder,
          enabledBorder: TextFormBorders.textFormEnabledBorder,
          focusedErrorBorder: TextFormBorders.textFormErrorBorder,
          errorBorder: TextFormBorders.textFormErrorBorder,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/top': (context) => const TopPage(),
        '/login': (context) => const LoginPage(),
        '/input': (context) => const InputTestDataPage(),
        '/map': (context) => const MapPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  String _appBarTitle = 'トップ'; // 初期タイトル

  // タイトルを更新するメソッド
  void _updateTitle(String newTitle) {
    setState(() {
      _appBarTitle = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_appBarTitle)), // 動的にタイトルを反映)
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: const Text('メニュー'),
            ),
            ListTile(
              title: Text('トップ'),
              onTap: () {
                _navigatorKey.currentState?.pushReplacementNamed('/top');
                _updateTitle("top");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('ログイン'),
              onTap: () {
                _navigatorKey.currentState?.pushNamed('/login');
                _updateTitle("login");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('データ登録'),
              onTap: () {
                _navigatorKey.currentState?.pushNamed('/input');
                _updateTitle("input");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("位置情報切り替え"),
              onTap: () {
                _navigatorKey.currentState?.pushNamed('/toggle_tracing');
                _updateTitle("toggle_tracing");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('マップ'),
              onTap: () {
                _navigatorKey.currentState?.pushReplacementNamed('/map');
                _updateTitle("map");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: '/map',
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/top':
              return MaterialPageRoute(builder: (context) {
                return TopPage();
              });
            case "/map":
              return MaterialPageRoute(builder: (context) {
                return MapPage();
              });
            case '/login':
              return MaterialPageRoute(builder: (context) {
                return LoginPage();
              });
            case '/input':
              return MaterialPageRoute(builder: (context) {
                return InputTestDataPage();
              });
            case "/toggle_tracing":
              return MaterialPageRoute(builder: (context) {
                return ToggleTracingPage();
              });
            default:
              builder = (context) => Center(child: Text('404'));
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
