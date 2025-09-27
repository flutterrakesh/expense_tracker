import 'dart:async';

import 'package:expense_app/routes/routes.dart';
import 'package:expense_app/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double _scale = 0.5;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
      });
    });
    Future.delayed(Duration(seconds: 3), (){
      Get.toNamed(Routes.home);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Center(child: AnimatedScale(
        scale: _scale,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut,
        child: Image.asset("assets/images/wallet_logo.png"),
      ),),
    );
  }
}
