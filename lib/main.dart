import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plogger/firebase_options.dart';
import 'package:plogger/home.dart';
import 'package:plogger/view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _requestPermission();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginView()
          : const Home(),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
    );
  }
}

Future<void> _requestPermission() async {
  if (!(await Permission.location.status).isGranted) {
    await Permission.location.request();
  }
  if (!(await Permission.camera.status).isGranted) {
    await Permission.camera.request();
  }
  if (!(await Permission.activityRecognition.status).isGranted) {
    await Permission.activityRecognition.request();
  }
}
