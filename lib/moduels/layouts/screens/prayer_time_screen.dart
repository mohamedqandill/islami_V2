import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_provider.dart';

class PrayerTimeScreen extends StatefulWidget {
  static const String routeName = "prayer";

  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

List<String> prayer = [
  "الفجر",
  "الظهر",
  "العصر",
  "المغرب",
  "العشاء",
];
var formattedDay;

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    formattedDay = DateFormat("dd-MMMM-yyyy").format(dateTime);
    print(formattedDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return bg_widget(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          " اوقات الصلاه",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: pro.mode == ThemeMode.dark ? Colors.white : Colors.black,
            )),
      ),
      body: FutureBuilder(
        future: pro.prayerTime(formattedDay, "Cairo"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return  Center(
              child:  Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 30,
                  ),
                  Text(snapshot.error.toString()),
                ],
              ),
            );
          }
          return Center(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(8.sp),
              height: 400.h,
              decoration: BoxDecoration(
                color: pro.mode == ThemeMode.dark
                    ? Colors.red.withOpacity(0.5.sp)
                    : Color(0xffB7935F),
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: Color(0xffFACC1D), width: 2),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "الصلاه",
                          style: TextStyle(
                              color: pro.mode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.orange),
                        ),
                        Text(
                          "الوقت",
                          style: TextStyle(
                              color: pro.mode == ThemeMode.dark
                                  ? Colors.black
                                  : Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: pro.mode == ThemeMode.dark
                        ? Color(0xffFACC1D)
                        : Colors.white,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: prayer.length,
                      itemBuilder: (context, index) {
                        List<String> prayerTime = [
                          pro.prayerTimeModel.data!.timings!.fajr.toString(),
                          pro.prayerTimeModel.data!.timings!.dhuhr.toString(),
                          pro.prayerTimeModel.data!.timings!.asr.toString(),
                          pro.prayerTimeModel.data!.timings!.maghrib.toString(),
                          pro.prayerTimeModel.data!.timings!.isha.toString(),
                        ];
                        List<String> formattedTime =
                            convertListTo12HourFormat(prayerTime);

                        return Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(prayer[index]),
                              Text(formattedTime[index]),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  List<String> convertListTo12HourFormat(List<String> timeList) {
    return timeList.map((time) {
      DateTime dateTime = DateFormat("HH:mm").parse(time);
      return DateFormat("h:mm a").format(dateTime);
    }).toList();
  }
}
