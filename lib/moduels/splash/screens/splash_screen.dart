import 'dart:async';

import 'package:flutter/material.dart';
import 'package:islami/moduels/layouts/layout_screen.dart';
import 'package:islami/moduels/layouts/screens/hadeth_details.dart';
import 'package:islami/moduels/layouts/screens/hadeth_screen.dart';
import 'package:islami/moduels/layouts/screens/sura_details.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(
          context, LayoutScreen.routeName, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/bg (1).png"),
        Center(child: Image.asset("assets/icons/logo.png")),
      ],
    );
  }
}
