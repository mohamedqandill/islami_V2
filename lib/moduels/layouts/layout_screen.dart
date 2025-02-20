import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/moduels/layouts/screens/azkar_masaa.dart';
import 'package:islami/moduels/layouts/screens/hadeth_screen.dart';
import 'package:islami/moduels/layouts/screens/home_screen.dart';
import 'package:islami/moduels/layouts/screens/quran_screen.dart';
import 'package:islami/moduels/layouts/screens/reciter_screen.dart';
import 'package:islami/moduels/layouts/screens/sebha_screen.dart';
import 'package:islami/moduels/layouts/screens/setting_screen.dart';
import 'package:islami/providers/my_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
    var pro=Provider.of<MyProvider>(context);
    return bg_widget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SettingScreen.routeName);
                },
                child: Lottie.asset(fit: BoxFit.cover,
                    delegates: LottieDelegates(
                      values: [
                        ValueDelegate.color(
                          const ['**'], // Change all colors in the animation
                          value: pro.mode==ThemeMode.dark? Colors.white:Colors.black, // Set your desired color
                        ),
                      ]
                    ),
                    "assets/icons/Animation - 1739711751213.json",width: 50.w,height: 50.h)),
          ],
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
              icon: Icon(size: 30.sp, Icons.audiotrack),
              label: "reciterTap".tr(),
            ),
          ],
        ),
        body: screen[selectedIndex],
      ),
    );
  }
}
