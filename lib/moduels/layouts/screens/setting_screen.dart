import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:islami/main.dart';
import 'package:islami/moduels/layouts/screens/language_bottom_sheet.dart';
import 'package:islami/moduels/layouts/screens/theme_bottom_sheet.dart';
import 'package:islami/providers/my_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});

  static const String routeName = "settings";

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                      return ThemeBottomSheet();
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
                          ? Color(0xffFACC1D)
                          : Color(0xffB7935F),
                      width: 3),
                ),
                child: Text(pro.mode == ThemeMode.light
                    ? "light".tr()
                    : "darkTap".tr()),
                padding: EdgeInsets.all(18),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                alignment: context.locale == Locale("ar")
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
                      return LanguageBottomSheet();
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
                          ? Color(0xffFACC1D)
                          : Color(0xffB7935F),
                      width: 3.w),
                ),
                child: context.locale == Locale("en")
                    ? Text("englishTap".tr())
                    : Text("arabicTap".tr()),
                padding: EdgeInsets.all(18.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
