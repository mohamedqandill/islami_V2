import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:islami/core/service/prefs.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/moduels/layouts/layout_screen.dart';
import 'package:islami/moduels/layouts/screens/hadeth/hadeth_details.dart';
import 'package:islami/moduels/layouts/screens/home/azkarSabah.dart';
import 'package:islami/moduels/layouts/screens/home/azkar_masaa.dart';
import 'package:islami/moduels/layouts/screens/home/nabi_screen.dart';
import 'package:islami/moduels/layouts/screens/quran/sura_details.dart';
import 'package:islami/moduels/splash/screens/splash_screen.dart';
import 'package:islami/providers/my_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tzData;
import 'package:workmanager/workmanager.dart';

import 'firebase_options.dart';
import 'moduels/layouts/screens/home/azkar_after_salah.dart';
import 'moduels/layouts/screens/home/doaa_screen.dart';
import 'moduels/layouts/screens/home/prayer_time_screen.dart';
import 'moduels/layouts/screens/home/quran_doaa_screen.dart';
import 'moduels/layouts/screens/home/tasbeh_screen.dart';
import 'moduels/layouts/screens/reciter/reciter_sura_screen.dart';
import 'moduels/layouts/screens/settings/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  var timeZone = await FlutterTimezone.getLocalTimezone();
  tzData.setLocalLocation(tzData.getLocation(timeZone));
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  print(tzData.getLocation(timeZone));
  print("TimeZone: ${tzData.local.name}");

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
        create: (context) => MyProvider(sharedPrefernces), child: MyApp()),
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
          DoaaScreen.routeName: (context) => DoaaScreen(),
          AzkarAfterSalah.routeName: (context) => AzkarAfterSalah(),
          QuranDoaa.routeName: (context) => QuranDoaa(),
          TasbehScreen.routeName: (context) => TasbehScreen(),
          // QiblaDirection.routeName: (context) => QiblaDirection(),
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
      ),
    );
  }
}

void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    SharedPrefs sharedPrefs = SharedPrefs();
    await sharedPrefs.init();
    int index = sharedPrefs.getInt("index") ?? 0;

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin.show(
      4,
      "اذكار",
      azkar[index % azkar.length],
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'ChannelID',
          'ChannelName',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
    print("herrrrre");
    await sharedPrefs.setInt("index", index + 1);
    print(index);
    return Future.value(true);
  });
}

List<String> azkar = [
  "سبحان الله وبحمده سبحان الله العظيم",
  "رضيتُ بالله ربًا، وبالإسلام دينًا، وبمحمد ﷺ نبيًا",
  "أستغفر الله العظيم وأتوب إليه",
  "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير",
  "اللهم إني أسألك خير هذا اليوم، فتحه ونصره ونوره وبركته",
  "سبحان الله و الحمدلله و لا اله الا الله و الله اكبر",
];
