import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea/main.dart';
import 'package:shoea/util/constant.dart';
import 'package:shoea/view/boarding/boarding_screen.dart';
import 'package:shoea/view/bottom_navigation/bottom_navigation_bar_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    checkSharedPreferences();
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

  void gotoOnboarding() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => const BoardingScreen()), (Route<dynamic> route) => false);
  }

  void gotoMainPage(){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => const BottomNavigationBarWidget()), (Route<dynamic> route) => false);
  }

  Future<void> checkSharedPreferences() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final data = sharedPrefs.getBool(userAuthKey);

    if(data == null || data == false){
      gotoOnboarding();
    } else {
      gotoMainPage();
    }
  }
}
