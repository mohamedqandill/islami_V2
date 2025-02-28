import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/main.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_provider.dart';

class SebhaScreen extends StatefulWidget {
  SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int counter = 0;
  List<String> title = [
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
  ];

  // Function? onClick;
  int index = 0;
  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);

    bool isDark = AppTheme.isDark;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 79.sp),
                      child: AnimatedRotation(
                        turns: turns,
                        duration: Duration(milliseconds: 150),
                        child: Image(
                            // fit: BoxFit.cover,
                            width: 200.w,
                            height: 200.h,
                            image: pro.mode == ThemeMode.dark
                                ? AssetImage("assets/icons/body of seb7a.png")
                                : AssetImage("assets/images/body of seb7a.png")),
                      ),
                    ),

                  ],
                ),
                Text(
                  "عدد التسبيحات",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: pro.mode == ThemeMode.dark
                        ? Color(0xffFACC1D).withOpacity(0.6)
                        : Color(0xffB7935F),
                  ),
                  alignment: Alignment.center,
                  width: 70.w,
                  height: 70.h,
                  child: Text(
                    "$counter",
                    style: TextStyle(fontSize: 30.sp),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: pro.mode == ThemeMode.dark
                            ? Color(0xffFACC1D).withOpacity(0.8)
                            : Color(0xffB7935F),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        fixedSize: Size(200.w, 50.h)),
                    onPressed: () {
                      turns += 1 / 18;
                      onClick();

                      setState(() {});
                    },
                    child: Text(
                      "${title[index]}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ))
              ],
            ),
            Positioned(
              bottom: 100.sp,
              right: 0,

              child: IconButton(onPressed: () {
                counter=0;
                turns=0.0;
                index=0;
                setState(() {

                });


              }, icon: Icon(Icons.repeat,size: 25.sp,)),
            )
          ],
        ),
      ),
    );
  }

  onClick() {
    counter++;
    if (counter == 33 && index == 0) {
      index++;
      counter = 0;
      title[index];
    } else if (counter == 33 && index == 1) {
      index++;
      counter = 0;
      title[index];
    } else if (counter == 33 && index == 2) {
      index++;
      counter = 0;
      title[index];
    } else if (counter == 33 && index == 3) {
      index = 0;
      counter = 0;
      title[index];
    }
  }
}
