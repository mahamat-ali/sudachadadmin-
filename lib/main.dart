import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sudachadadmin/screens/home_screen.dart';
import 'package:sudachadadmin/screens/login_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sudachad admin',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(209, 56, 131, 1),
        accentColor: Color.fromRGBO(37, 39, 50, 1),
      ),
      home: LoaderOverlay(
        overlayColor: Colors.blueGrey,
        child: LoginScreen(),
      ),
    );
  }
}
