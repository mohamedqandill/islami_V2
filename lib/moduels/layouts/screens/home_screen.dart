import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:islami/moduels/layouts/layout_screen.dart';
import 'package:islami/moduels/layouts/screens/azkarSabah.dart';
import 'package:islami/moduels/layouts/screens/azkar_masaa.dart';
import 'package:islami/moduels/layouts/screens/nabi_screen.dart';
import 'package:islami/moduels/layouts/screens/prayer_time_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> doaa = [
    """اللهم إني أعوذ بك من زوال نعمتك، وتحول عافيتك وفجاءة نقمتك، وجميع سخطك”. أخرجه مسلم""",
    """اللهم إني أعوذ بك من البرص والجنون والجذام ومن سيئ الأسقام”. أخرجه أبو داود والنسائي"""
        """اللهم إني أعوذ بك من الفقر والقلة والذلة وأعوذ بك من أن أظلم أو أظلم”. أخرجه أبو داود والنسائي""",
    """اللهم إني أسألك بأني أشهد أنك أنت الله لا إله إلا أنت الأحد الصمد الذي لم يلد ولم يولد ولم يكن له كفوا أحد”. أخرجه الترمذي وابن ماجه""",
    """اللهم اجعل في قلبي نورا، وفي بصري نورا، وفي سمعي نورا، وعن يميني نورا، وعن يساري نورا، وفوقي نورا، وتحتي نورا، وأمامي نورا، وخلفي نورا، وعظم لي نورا”. أخرجه مسلم""",
    """اللهم أصلح لي ديني الذي هو عصمة أمري، وأصلح لي دنياي التي فيها معاشي، وأصلح لي آخرتي التي فيها معادي، واجعل الحياة زيادة لي في كل خير، واجعل الموت راحة لي من كل شر”. أخرجه مسلم""",
  ];

  int index = 0;
  double width = 200.w;

  @override
  Widget build(BuildContext context) {
    // bool isDark = AppTheme.isDark;
    var pro = Provider.of<MyProvider>(context);

    return bg_widget(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40.sp, left: 10.sp, right: 10.sp),
              padding: EdgeInsets.all(15.sp),
              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                  color: pro.mode == ThemeMode.dark
                      ? Colors.black12
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60.r),
                    bottomLeft: Radius.circular(20.r),
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(10.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffB7935F),
                      blurRadius: 30.sp,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                  border: Border.all(color: Color(0xffB7935F), width: 3.w)),
              child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: Text(
                    "${doaa[index]}",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ))),
            ),
            SizedBox(
              height: 30.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(width, 60.w),
                  backgroundColor: pro.mode == ThemeMode.dark
                      ? Color(0xffFACC1D).withOpacity(0.5)
                      : Color(0xffB7935F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  side: BorderSide(
                    color: Colors.white,
                    width: 1.w,
                  ),
                  elevation: 8,
                  shadowColor: Colors.amber),
              onPressed: () {
                index++;
                if (index == 5) {
                  index = 0;
                }
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "تغيير الدعاء",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Image(
                    image: AssetImage(
                      "assets/icons/icons8-swap-50.png",
                    ),
                    width: 30.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 120 / 50,
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 20),
                children: [
                  Padding(
                    padding: EdgeInsets.all(3.0.sp),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(200.w, 50.h),
                          backgroundColor: pro.mode == ThemeMode.dark
                              ? Color(0xffFACC1D).withOpacity(0.5)
                              : Color(0xffB7935F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          side: BorderSide(
                            color: Colors.white,
                            width: 1.w,
                          ),
                          elevation: 8,
                          shadowColor: Colors.amber),
                      onPressed: () {
                        Navigator.pushNamed(context, AzkarSabah.routeName);
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "اذكار الصباح ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          // Image(image: AssetImage("assets/icons/icons8-swap-50.png",),width: 40,),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(220.w, 50.h),
                        backgroundColor: pro.mode == ThemeMode.dark
                            ? Color(0xffFACC1D).withOpacity(0.5)
                            : Color(0xffB7935F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        elevation: 8,
                        shadowColor: Colors.amber),
                    onPressed: () {
                      Navigator.pushNamed(context, NabiScreen.routeName);
                      setState(() {});
                    },
                    child: Text(
                      "الصلاه علي النبي",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(200.w, 50.h),
                          backgroundColor: pro.mode == ThemeMode.dark
                              ? Color(0xffFACC1D).withOpacity(0.5)
                              : Color(0xffB7935F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide(
                            color: Colors.white,
                            width: 1.w,
                          ),
                          elevation: 8,
                          shadowColor: Colors.amber),
                      onPressed: () {
                        Navigator.pushNamed(context, AzkarMasaa.routeName);
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "اذكار المساء",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          // Image(image: AssetImage("assets/icons/icons8-swap-50.png",),width: 40,),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(200.w, 50.h),
                          backgroundColor: pro.mode == ThemeMode.dark
                              ? Color(0xffFACC1D).withOpacity(0.5)
                              : Color(0xffB7935F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          elevation: 8,
                          shadowColor: Colors.amber),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PrayerTimeScreen.routeName);
                      },
                      child: Text(
                        "مواقيت الصلاه",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
