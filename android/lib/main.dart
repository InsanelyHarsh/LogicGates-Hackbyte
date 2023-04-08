import 'package:android/models/available_cameras.dart';
import 'package:android/views/login/login.dart';
import 'package:android/views/login/signup.dart';
import 'package:android/views/tab_bars/camera_recorder.dart';
import 'package:android/views/tab_bars/home.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// kotlin '1.6.10'
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AvailableCameras()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const Login(),
          '/login': (context) => const Login(),
          '/signup': (context) => const Signup(),
          '/home': (context) => const Home(),
          '/camera': (context) => const CameraRecorder(),
        },
      ),
    );
  }
}
