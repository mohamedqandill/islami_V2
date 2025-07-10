import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:islami/moduels/layouts/screens/settings/language_bottom_sheet.dart';
import 'package:islami/moduels/layouts/screens/settings/theme_bottom_sheet.dart';
import 'package:islami/providers/my_provider.dart';
import 'package:prayers_times/prayer_times.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../core/service/notification_service.dart';
import '../../../../core/service/prefs.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});

  static const String routeName = "settings";

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var controller = ValueNotifier<bool>(false);
  bool? checkedValue;
  var selectedTime = TimeOfDay.fromDateTime(DateTime.now());
  var formattedAzkarSabah;
  var formattedAzkarMasaa;
  late DateTime maghribTime;
  late SharedPrefs sharedPrefs;
  late NotificationService notificationService;

  @override
  void initState() {
    notificationService = NotificationService();
    sharedPrefs = SharedPrefs();
    initPrefs();
    getPrayerTimes();

    super.initState();
  }

  getPrayerTimes() {
    Coordinates coordinates = Coordinates(30.0444, 31.2357);
    PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
    PrayerTimes prayerTimes = PrayerTimes(coordinates, DateTime.now(), params);
    maghribTime = prayerTimes.maghrib!.toLocal();
    print(prayerTimes.maghrib!.toLocal());
    print(prayerTimes.dhuhr!.toLocal());
    print(prayerTimes.asr!.toLocal());
    print(prayerTimes.isha!.toLocal());
    print(prayerTimes.fajr!.toLocal());
  }

  Future<void> initPrefs() async {
    await sharedPrefs.init().then(
      (value) {
        setState(() {
          final savedValue = sharedPrefs.getBool("checkedValue") ?? false;
          controller.value = savedValue;
          formattedAzkarSabah = sharedPrefs.getString("azkarSabah");
          formattedAzkarMasaa = sharedPrefs.getString("azkarMasaa");
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return bg_widget(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: pro.mode == ThemeMode.dark ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Container(
                alignment: context.locale == Locale("ar")
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                margin:
                    EdgeInsets.only(left: 20.sp, bottom: 2.sp, right: 20.sp),
                child: Text("themeTap".tr())),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    builder: (context) {
                      return const ThemeBottomSheet();
                    });
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10.sp),
                height: 70.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                      color: pro.mode == ThemeMode.dark
                          ? const Color(0xffFACC1D)
                          : const Color(0xffB7935F),
                      width: 3),
                ),
                padding: const EdgeInsets.all(18),
                child: Text(pro.mode == ThemeMode.light
                    ? "light".tr()
                    : "darkTap".tr()),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                alignment: context.locale == const Locale("ar")
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                margin:
                    EdgeInsets.only(left: 20.sp, bottom: 2.sp, right: 20.sp),
                child: Text("languageTap".tr())),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    builder: (context) {
                      return const LanguageBottomSheet();
                    });
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10.sp),
                height: 70.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                      color: pro.mode == ThemeMode.dark
                          ? const Color(0xffFACC1D)
                          : const Color(0xffB7935F),
                      width: 3.w),
                ),
                padding: EdgeInsets.all(18.sp),
                child: context.locale == const Locale("en")
                    ? Text("englishTap".tr())
                    : Text("arabicTap".tr()),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       fixedSize: Size(200.w, 50.h),
            //       backgroundColor: pro.mode == ThemeMode.dark
            //           ? const Color(0xffFACC1D).withOpacity(0.5)
            //           : const Color(0xffB7935F),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20.r),
            //       ),
            //       side: BorderSide(
            //         color: Colors.white,
            //         width: 1.w,
            //       ),
            //       elevation: 8,
            //       shadowColor: Colors.amber),
            //   onPressed: () {
            //     // Navigator.pushNamed(context, QiblaDirection.routeName);
            //
            //     setState(() {});
            //   },
            //   child: Text(
            //     "القبله",
            //     style: Theme.of(context).textTheme.bodyMedium,
            //   ),
            // ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "الاشعارات",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  AdvancedSwitch(
                    controller: controller,
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                    width: 80.0,
                    height: 40.0,
                    enabled: true,
                    disabledOpacity: 0.5,
                    onChanged: (value) async {
                      controller.value = value;
                      setState(() {});
                      if (controller.value) {
                        initNotification();
                        await Workmanager().registerPeriodicTask(
                          "azkarNotificationTask",
                          "simplePeriodicTask",
                          frequency: const Duration(minutes: 15),
                          constraints: Constraints(
                            networkType: NetworkType.not_required,
                            requiresBatteryNotLow: false,
                            requiresCharging: false,
                            requiresDeviceIdle: false,
                            requiresStorageNotLow: false,
                          ),
                        );
                        await Workmanager().registerPeriodicTask(
                          "dailyPrayerUpdateTask",
                          "dailyPrayerTask",
                          frequency: const Duration(minutes: 15),
                          initialDelay: getDelayUntilNext1AM(),
                          constraints: Constraints(
                            networkType: NetworkType.not_required,
                            requiresBatteryNotLow: false,
                            requiresCharging: false,
                            requiresDeviceIdle: false,
                            requiresStorageNotLow: false,
                          ),
                        );
                      }
                      if (!controller.value) {
                        notificationService.cancelAll();
                        await Workmanager()
                            .cancelByUniqueName("azkarNotificationTask");
                      }

                      await sharedPrefs.setBool(
                          "checkedValue", controller.value);
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: controller.value,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "موعد اذكار الصباح",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Row(
                          children: [
                            formattedAzkarSabah != null
                                ? Text(
                                    "$formattedAzkarSabah",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                : const SizedBox(),
                            SizedBox(
                              width: 8.sp,
                            ),
                            InkWell(
                                onTap: () async {
                                  selectedTime = await selctedTime();
                                  final now = DateTime.now();
                                  final selectedDateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    selectedTime.hour,
                                    selectedTime.minute,
                                  );

                                  formattedAzkarSabah = DateFormat('h:mm a')
                                      .format(selectedDateTime);

                                  if (formattedAzkarSabah != null) {
                                    if (selectedDateTime.hour >=
                                        maghribTime.hour) {
                                      formattedAzkarSabah = "";
                                      await sharedPrefs.remove("azkarSabah");
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                          'وقت الأذكار الصباحية يجب أن يكون قبل المغرب',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        )),
                                      );
                                      return;
                                    } else {
                                      await sharedPrefs.setString(
                                          "azkarSabah", formattedAzkarSabah);
                                    }
                                    print(selectedDateTime.hour);
                                    print(selectedDateTime.minute);
                                    print(
                                        "⌛ إشعار هيظهر عند: ${selectedTime.hour}:${selectedDateTime.minute}");
                                    await notificationService
                                        .scheduledNotification(
                                            title: "اذكار",
                                            body: "موعد اذكار الصباح",
                                            id: 6,
                                            hour: selectedDateTime.hour,
                                            minutes: selectedDateTime.minute);
                                  }

                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.timelapse,
                                  size: 28.sp,
                                ))
                          ],
                        ),
                        // TextButton(onPressed: () {
                        //   notificationService.scheduledNotification(hour: hour,
                        //       minutes: minutes,
                        //       title: title,
                        //       body: body,
                        //       id: id)
                        // }, child: Text("Schedule notification"))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 19.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "موعد اذكار المساء",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Row(
                          children: [
                            formattedAzkarMasaa != null
                                ? Text(
                                    "$formattedAzkarMasaa",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                : const SizedBox(),
                            SizedBox(
                              width: 8.sp,
                            ),
                            InkWell(
                                onTap: () async {
                                  selectedTime = await selctedTime();
                                  final now = DateTime.now();
                                  final selectedDateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    selectedTime.hour,
                                    selectedTime.minute,
                                  );

                                  formattedAzkarMasaa = DateFormat('h:mm a')
                                      .format(selectedDateTime);

                                  if (formattedAzkarMasaa != null) {
                                    if (selectedDateTime.hour <=
                                        maghribTime.hour) {
                                      formattedAzkarMasaa = "";
                                      await sharedPrefs.remove("azkarMasaa");
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                          'وقت الأذكار المسائيه يجب أن يكون بعد المغرب',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        )),
                                      );
                                      return;
                                    } else {
                                      await sharedPrefs.setString(
                                          "azkarMasaa", formattedAzkarMasaa);
                                    }
                                    print(selectedDateTime.hour);
                                    print(selectedDateTime.minute);
                                    print(
                                        "⌛ إشعار هيظهر عند: ${selectedTime.hour}:${selectedDateTime.minute}");
                                    await notificationService
                                        .scheduledNotification(
                                            title: "اذكار",
                                            body: "موعد اذكار المساء",
                                            id: 6,
                                            hour: selectedDateTime.hour,
                                            minutes: selectedDateTime.minute);
                                  }

                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.timelapse,
                                  size: 28.sp,
                                ))
                          ],
                        ),
                        // TextButton(onPressed: () {
                        //   notificationService.scheduledNotification(hour: hour,
                        //       minutes: minutes,
                        //       title: title,
                        //       body: body,
                        //       id: id)
                        // }, child: Text("Schedule notification"))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<TimeOfDay> selctedTime() async {
    var time =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (time != null) {
      return time;
    } else {
      return selectedTime;
    }
  }

  initNotification() async {
    await notificationService.initializeNotification();
  }

  Duration getDelayUntilNext1AM() {
    DateTime now = DateTime.now();
    DateTime next1AM = DateTime(now.year, now.month, now.day + 1, 1);

    return next1AM.difference(now);
  }
}
