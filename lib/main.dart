import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoea/firebase_options.dart';
import 'package:shoea/view/splash/splash_screen.dart';
const userAuthKey = "User_Auth";

void main(List<String> args) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}