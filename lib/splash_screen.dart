import 'package:ecom_app/Core/Common/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const NavBar(),
          ),
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: h,
        width: w,
        child: Center(child: Lottie.asset('images/movies.json')),
      ),
    );
  }
}
