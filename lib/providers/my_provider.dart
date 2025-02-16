import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:islami/models/PrayerTimeModel.dart';
import 'package:islami/models/ReciterModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/suraAudioModel.dart';

class MyProvider extends ChangeNotifier {
  late ThemeMode mode;
  late Dio dio;
  late PrayerTimeModel prayerTimeModel;
  late ReciterModel reciterModel;
  late String audioFile;
  late Position position;


  static const String isDarkTheme = "Theme";

  final SharedPreferences prefs;

  MyProvider(this.prefs) {
    readSavedTheme();
    dio = Dio();
  }

  void readSavedTheme() {
    var isDark = prefs.getBool(isDarkTheme) ?? false;
    mode = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void saveTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isDarkTheme, mode == ThemeMode.dark);
  }

  changeTheme(ThemeMode themeMode) {
    mode = themeMode;

    notifyListeners();
    saveTheme();
  }

  Future<PrayerTimeModel> prayerTime(String date, String address) async {
    try {
      var response = await dio.get(
        "https://api.aladhan.com/v1/timingsByAddress",
        queryParameters: {"date": date, "address": address},
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        prayerTimeModel = PrayerTimeModel.fromJson(response.data);
      }

      return prayerTimeModel;
    } catch (e) {
      rethrow;
    }
  }

  getAllReciter() async {
    try {
      var response = await dio.get(
        "https://api.quran.com/api/v4/resources/recitations",
        queryParameters: {
          "language": "ar",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        reciterModel = ReciterModel.fromJson(response.data);

      }

      return reciterModel;
    } catch (e) {
      rethrow;
    }
  }
  Future<String> suraAudio({required int id, required int chapter}) async {

    try {
      var response = await dio.get(
        "https://api.quran.com/api/v4/chapter_recitations/$id/$chapter",

      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        SuraAudioModel suraAudioModel = SuraAudioModel.fromJson(response.data);
        audioFile=suraAudioModel.audioFile?.audioUrl??"";
        print(suraAudioModel.audioFile?.audioUrl??"");
        notifyListeners();


      }

      return audioFile ;
    } catch (e) {
      rethrow;
    }
  }




}
