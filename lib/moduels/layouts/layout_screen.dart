import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/moduels/layouts/screens/hadeth/hadeth_screen.dart';
import 'package:islami/moduels/layouts/screens/home/home_screen.dart';
import 'package:islami/moduels/layouts/screens/quran/quran_screen.dart';
import 'package:islami/moduels/layouts/screens/reciter/reciter_screen.dart';
import 'package:islami/moduels/layouts/screens/sebha/sebha_screen.dart';
import 'package:islami/moduels/layouts/screens/settings/setting_screen.dart';
import 'package:islami/providers/my_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
  ReciterScreen(),
];
List<String> titels = [
  "quran",
  'appBarTitle',
  'appBarHadeth',
  'appBarTaspeh',
  'appBarReciter'
];

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return bg_widget(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SettingScreen.routeName);
                    },
                    child: Lottie.asset(
                        fit: BoxFit.cover,
                        delegates: LottieDelegates(values: [
                          ValueDelegate.color(
                            const ['**'],
                            // Change all colors in the animation
                            value: pro.mode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black, // Set your desired color
                          ),
                        ]),
                        "assets/icons/Animation - 1739711751213.json",
                        width: 50.w,
                        height: 50.h)),
              ],
              title: Text(
                titels[selectedIndex].tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            bottomNavigationBar: SalomonBottomBar(
              backgroundColor: pro.mode == ThemeMode.dark
                  ? Color(0xff141A2E)
                  : Color(0xffB7935F),
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
                SalomonBottomBarItem(
                    icon: ImageIcon(
                        size: 35.sp, AssetImage("assets/icons/icon_quran.png")),
                    title: Text("${"quranTap".tr()}"),
                    selectedColor: pro.mode == ThemeMode.dark
                        ? Color(0xffFACC1D)
                        : Colors.white),
                SalomonBottomBarItem(
                    icon: ImageIcon(
                        size: 30.sp,
                        AssetImage("assets/icons/icons8-home-64.png")),
                    title: Text(""),
                    selectedColor: pro.mode == ThemeMode.dark
                        ? Color(0xffFACC1D)
                        : Colors.white),
                SalomonBottomBarItem(
                    icon: ImageIcon(
                        size: 32.sp,
                        AssetImage("assets/icons/icon_hadeth.png")),
                    title: Text("${'hadethTap'.tr()}"),
                    selectedColor: pro.mode == ThemeMode.dark
                        ? Color(0xffFACC1D)
                        : Colors.white),
                SalomonBottomBarItem(
                    icon: ImageIcon(
                        size: 32.sp, AssetImage("assets/icons/icon_sebha.png")),
                    title: Text("${"tasbehTap".tr()}"),
                    selectedColor: pro.mode == ThemeMode.dark
                        ? Color(0xffFACC1D)
                        : Colors.white),
                SalomonBottomBarItem(
                    icon: Icon(size: 32.sp, Icons.audiotrack),
                    title: Text("${"reciterTap".tr()}"),
                    selectedColor: pro.mode == ThemeMode.dark
                        ? Color(0xffFACC1D)
                        : Colors.white),
              ],
            ),
            body: Column(
              children: [
                Expanded(child: screen[selectedIndex]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
