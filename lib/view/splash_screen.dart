import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtronic_test_rizky/configs/constant.dart';
import 'package:newtronic_test_rizky/view/beranda_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(
      duration,
      () {
        Get.offAll(()=>const BerandaScreen(),transition: Transition.rightToLeft);
      },
    );
  }

  @override
  void initState() {
    startSplashScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: whiteColor,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo_newtronic.png",
                    scale: 4,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}