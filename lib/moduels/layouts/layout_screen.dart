import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/moduels/layouts/screens/azkar_masaa.dart';
import 'package:islami/moduels/layouts/screens/hadeth_screen.dart';
import 'package:islami/moduels/layouts/screens/home_screen.dart';
import 'package:islami/moduels/layouts/screens/quran_screen.dart';
import 'package:islami/moduels/layouts/screens/sebha_screen.dart';
import 'package:islami/moduels/layouts/screens/setting_screen.dart';

import '../../core/widgets/bg_widget.dart';

class LayoutScreen extends StatefulWidget {
  static const String routeName = "layout";

  LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

List<Widget> screen = [
  QuranScreen(),
  HomeScreen(),
  HadethScreen(),
  SebhaScreen(),
  SettingScreen(),
];
List<String> titels = [
  "quran",
  'appBarTitle',
  'appBarHadeth',
  'appBarTaspeh',
  'appBarSettings'
];

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return bg_widget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            titels[selectedIndex].tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },

          currentIndex: selectedIndex,

          // curveSize: 150,
          // elevation: 10,

          // backgroundColor: Color(0xff141A2E),
          // color: Colors.black,
          // cornerRadius: 30,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(
                    size: 40.sp, AssetImage("assets/icons/icon_quran.png")),
                label: "quranTap".tr()),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    size: 40.sp, AssetImage("assets/icons/icons8-home-64.png")),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    size: 40.sp, AssetImage("assets/icons/icon_hadeth.png")),
                label: 'hadethTap'.tr()),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    size: 40.sp, AssetImage("assets/icons/icon_sebha.png")),
              label: "tasbehTap".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(size: 30.sp, Icons.settings),
              label: "settingsTap".tr(),
            ),
          ],
        ),
        body: screen[selectedIndex],
      ),
    );
  }
}
