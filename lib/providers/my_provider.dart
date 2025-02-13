import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:islami/models/PrayerTimeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  late ThemeMode mode;
  late Dio dio;
 late PrayerTimeModel prayerTimeModel;
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
    try{
      var response = await dio.get(
        "https://api.aladhan.com/v1/timingsByAddress",
        queryParameters: {"date": date, "address": address},
      );
      print(response.statusCode);
       if(response.statusCode==200){
         prayerTimeModel= PrayerTimeModel.fromJson(response.data);

       }

      return prayerTimeModel;

    }catch(e){
      rethrow;
    }
  }

  // getLocation()async{
  //
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   LocationData _locationData;
  //
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   _locationData = await location.getLocation();
  //
  // }
  Future<void> checkAndRequestLocationPermission() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled. Please enable them.");
      return;
    }

    // Check current permission status
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle permanently denied permission
      print("Location permission is permanently denied. You need to enable it from settings.");
      return;
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      // Permission granted, proceed with location retrieval
      print("Location permission granted.");
       position = await Geolocator.getCurrentPosition();
      print("Current Location: ${position.latitude}, ${position.longitude}");
    }
  }
  Future<String?> getCityName( ) async {
    try {

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Get the city name
      if (placemarks.isNotEmpty) {
        print(placemarks.first.locality);
        return placemarks.first.locality; // Example: "Cairo"
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

}
