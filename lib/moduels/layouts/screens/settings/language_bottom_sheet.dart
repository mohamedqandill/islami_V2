import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/main.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0.sp),
      child: Container(
        margin: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.r)),
        // width: double.infinity,
        height: 180.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                context.setLocale(Locale("en"));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "englishTap".tr(),
                    style: TextStyle(color: Color(0xffB7935F), fontSize: 30),
                  ),
                  context.locale == Locale("en")
                      ? Icon(
                          Icons.done,
                          size: 30.sp,
                          color: Colors.black,
                        )
                      : SizedBox()
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            InkWell(
              onTap: () {
                context.setLocale(Locale("ar"));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "arabicTap".tr(),
                    style: TextStyle(color: Color(0xffB7935F), fontSize: 30),
                  ),
                  // Icon(Icons.done,size: 30,color: Colors.black,)
                  context.locale == Locale("ar")
                      ? Icon(
                          Icons.done,
                          size: 30.sp,
                          color: Colors.black,
                        )
                      : SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
