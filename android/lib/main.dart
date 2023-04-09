
import 'package:android/models/local_db.dart';
import 'package:android/views/login/login.dart';
import 'package:android/views/login/signup.dart';
import 'package:android/views/tab_bars/camera_recorder.dart';
import 'package:android/views/tab_bars/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// kotlin '1.6.10'
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (_) => LocalDb(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = false;
  bool isLoggedIn = false;
  helper() async {
    setState(() {
      isLoading = true;
    });
    debugPrint('search user');
    final localDb = Provider.of<LocalDb>(context, listen: false);
    await localDb.checkForUserDetailsFromLocalDb();
    setState(() {
      isLoading = false;
      isLoggedIn = localDb.isLoggedIn;
      debugPrint(isLoggedIn.toString());
    });
  }

  @override
  void initState() {
    helper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (isLoggedIn ? const Home() : const Login()),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        '/home': (context) => const Home(),
        '/camera': (context) => const CameraRecorder(),
      },
    );
  }
}
