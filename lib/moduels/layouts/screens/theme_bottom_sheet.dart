import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/main.dart';
import 'package:islami/providers/my_provider.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = false;
    var pro = Provider.of<MyProvider>(context);
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
                pro.changeTheme(ThemeMode.light);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'light'.tr(),
                    style: TextStyle(
                        color: pro.mode == ThemeMode.light
                            ? Color(0xffB7935F)
                            : Colors.black,
                        fontSize: 30.sp),
                  ),
                  pro.mode == ThemeMode.light
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
                pro.changeTheme(ThemeMode.dark);
                dark = true;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'darkTap'.tr(),
                    style: TextStyle(
                        color: pro.mode == ThemeMode.dark
                            ? Color(0xffB7935F)
                            : Colors.black,
                        fontSize: 30.sp),
                  ),
                  pro.mode == ThemeMode.dark
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
