import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/main.dart';

class SplashScreen extends StatefulWidget {
  static final Duration _duration = Duration(milliseconds: 1750);
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(
      Duration(
        seconds: 2,
      ),
          () async{
        navigatorKey.currentState!.pushReplacementNamed(PagesRouteName.LoginPage);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightScaffoldColor,
      body: Stack(
        children: [
          ZoomIn(
            duration: SplashScreen._duration,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                  width: double.infinity,
                  height: 300,
                  child: Image(
                    image: AssetImage("assets/images/Logo.png"),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
