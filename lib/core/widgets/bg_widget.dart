import 'package:flutter/material.dart';
import 'package:islami/providers/my_provider.dart';
import 'package:provider/provider.dart';

class bg_widget extends StatelessWidget {
  bg_widget({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    // bool isDark = AppTheme.isDark;
    var pro = Provider.of<MyProvider>(context);
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(pro.mode == ThemeMode.dark
                    ? "assets/images/bg (1).png"
                    : "assets/images/default_bg.png"))),
        child: child);
  }
}
