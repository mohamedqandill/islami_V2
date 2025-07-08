// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
// import 'package:flutter_compass/flutter_compass.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../providers/my_provider.dart';
//
// class QiblaDirection extends StatefulWidget {
//   static const String routeName = "qiblah";
//   @override
//   _QiblaDirectionState createState() => _QiblaDirectionState();
// }
//
// class _QiblaDirectionState extends State<QiblaDirection> {
//   double? _heading = 0;
//   double _qiblaDirection = 0;
//   bool _locationPermissionGranted = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _requestLocationPermission();
//     FlutterCompass.events!.listen((event) {
//       setState(() {
//         _heading = event.heading;
//       });
//     });
//   }
//
//   Future<void> _requestLocationPermission() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       setState(() {
//         _locationPermissionGranted = false;
//       });
//     } else {
//       setState(() {
//         _locationPermissionGranted = true;
//       });
//       _getQiblaDirection();
//     }
//   }
//
//   Future<void> _getQiblaDirection() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//
//     double lat = position.latitude;
//     double lng = position.longitude;
//
//     double kaabaLat = 21.4225;
//     double kaabaLng = 39.8262;
//     double deltaLng = (kaabaLng - lng).toRad();
//
//     double y = math.sin(deltaLng) * math.cos(kaabaLat.toRad());
//     double x = math.cos(lat.toRad()) * math.sin(kaabaLat.toRad()) -
//         math.sin(lat.toRad()) * math.cos(kaabaLat.toRad()) * math.cos(deltaLng);
//
//     double qiblaAngle = math.atan2(y, x).toDeg();
//     setState(() {
//       _qiblaDirection = (qiblaAngle + 360) % 360;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double difference = ((_heading ?? 0) - _qiblaDirection).abs();
//     var pro = Provider.of<MyProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//           leading: InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() {});
//               },
//               child: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//               )),
//           title: const Text(
//             "اتجاه القبلة",
//             style: TextStyle(color: Colors.white),
//           )),
//       body: Center(
//         child: _locationPermissionGranted
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Transform.rotate(
//                     angle: ((_heading ?? 0) - _qiblaDirection).toRad(),
//                     child: Image.asset("assets/images/image.png", width: 200.w),
//                   ),
//                   const SizedBox(height: 20),
//                   if (difference < 5)
//                     const Text(
//                       "الاتجاه مضبوط! 🎯",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green),
//                     ),
//                 ],
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                       "يجب السماح بالوصول إلى الموقع لمعرفة اتجاه القبلة"),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _requestLocationPermission,
//                     child: const Text("طلب الإذن"),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
//
// extension on num {
//   double toRad() => this * (math.pi / 180.0);
//   double toDeg() => this * (180.0 / math.pi);
// }
