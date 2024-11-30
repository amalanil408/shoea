import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shoea/util/constant.dart';
import 'package:shoea/view/boarding/boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    gotoOnboarding();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGroundColor,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/img/logo.jpg',
              fit: BoxFit.contain,
            ),
          ),
          const Positioned(
            bottom: 40, 
            left: 0,
            right: 0,
            child: SpinKitCircle(
              color: Colors.black,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  void gotoOnboarding() async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => const BoardingScreen()), (Route<dynamic> route) => false);
  }
}
