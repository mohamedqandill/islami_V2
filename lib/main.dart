import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/moduels/layouts/layout_screen.dart';
import 'package:islami/moduels/layouts/screens/azkarSabah.dart';
import 'package:islami/moduels/layouts/screens/azkar_masaa.dart';
import 'package:islami/moduels/layouts/screens/hadeth_details.dart';
import 'package:islami/moduels/layouts/screens/nabi_screen.dart';
import 'package:islami/moduels/layouts/screens/sura_details.dart';
import 'package:islami/moduels/splash/screens/splash_screen.dart';
import 'package:islami/providers/my_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'moduels/layouts/screens/prayer_time_screen.dart';
import 'moduels/layouts/screens/reciter_sura_screen.dart';
import 'moduels/layouts/screens/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var sharedPrefernces = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: [Locale("en"), Locale("ar")],
    path: 'assets/translations',
    startLocale: Locale("ar"),
    saveLocale: true,
    // <-- change the path of the translation files
    fallbackLocale: Locale('en', 'US'),
    child: ChangeNotifierProvider(
        create: (context) => MyProvider(sharedPrefernces),
        child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: pro.mode,
        debugShowCheckedModeBanner: false,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          LayoutScreen.routeName: (context) => LayoutScreen(),
          SuraDetails.routeName: (context) => SuraDetails(),
          HadethDetails.routeName: (context) => HadethDetails(),
          NabiScreen.routeName: (context) => NabiScreen(),
          AzkarSabah.routeName: (context) => AzkarSabah(),
          AzkarMasaa.routeName: (context) => AzkarMasaa(),
          PrayerTimeScreen.routeName: (context) => PrayerTimeScreen(),
          SettingScreen.routeName: (context) => SettingScreen(),
          ReciterSuraScreen.routeName: (context) => ReciterSuraScreen(),
        },
        initialRoute: SplashScreen.routeName,
        // localizationsDelegates: [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: [
        //   Locale('en'), // English
        //   Locale('ar'), // Spanish
        // ],
      ) ,

    );
  }
}
