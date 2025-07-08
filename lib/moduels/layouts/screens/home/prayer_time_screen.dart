import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:provider/provider.dart';

import '../../../../providers/my_provider.dart';

class PrayerTimeScreen extends StatefulWidget {
  static const String routeName = "prayer";

  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  List<String> prayer = ["الفجر", "الظهر", "العصر", "المغرب", "العشاء"];
  late String formattedDay;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();
    formattedDay = DateFormat("dd-MMMM-yyyy").format(dateTime);
    _loadPrayerTimes();
  }

  Future<void> _loadPrayerTimes() async {
    try {
      var pro = Provider.of<MyProvider>(context, listen: false);

      await pro.prayerTime(formattedDay, "Cairo");
    } catch (e) {
      setState(() {
        errorMessage = "فشل تحميل أوقات الصلاة: ${e.toString()}";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);

    return bg_widget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "اوقات الصلاه",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: pro.mode == ThemeMode.dark ? Colors.white : Colors.black,
            ),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 30, color: Colors.red),
                        Text("No Internet Connection",
                            style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  )
                : pro.prayerTimeModel.data?.timings == null
                    ? const Center(
                        child: Text("لم يتم العثور على بيانات الصلاة"))
                    : _buildPrayerTimeUI(pro),
      ),
    );
  }

  Widget _buildPrayerTimeUI(MyProvider pro) {
    List<String> prayerTime = [
      pro.prayerTimeModel.data!.timings!.fajr ?? "00:00",
      pro.prayerTimeModel.data!.timings!.dhuhr ?? "00:00",
      pro.prayerTimeModel.data!.timings!.asr ?? "00:00",
      pro.prayerTimeModel.data!.timings!.maghrib ?? "00:00",
      pro.prayerTimeModel.data!.timings!.isha ?? "00:00",
    ];
    List<String> formattedTime = convertListTo12HourFormat(prayerTime);

    return Center(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(8.sp),
        height: 400.h,
        decoration: BoxDecoration(
          color: pro.mode == ThemeMode.dark
              ? Colors.red.withOpacity(0.5.sp)
              : const Color(0xffB7935F),
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: const Color(0xffFACC1D), width: 2.w),
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
                          : Colors.orange,
                    ),
                  ),
                  Text(
                    "الوقت",
                    style: TextStyle(
                      color: pro.mode == ThemeMode.dark
                          ? Colors.black
                          : Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: pro.mode == ThemeMode.dark
                  ? const Color(0xffFACC1D)
                  : Colors.white,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: prayer.length,
                itemBuilder: (context, index) {
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
  }

  List<String> convertListTo12HourFormat(List<String> timeList) {
    return timeList.map((time) {
      try {
        DateTime dateTime = DateFormat("H:mm", 'en').parse(time);
        // ضبط اللغة على الإنجليزية
        return DateFormat("h:mm a", 'en').format(dateTime);
      } catch (e) {
        return "غير متاح";
      }
    }).toList();
  }
}
