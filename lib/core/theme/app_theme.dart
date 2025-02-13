import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';

class AppTheme {
  static final Color lightPrimary = Color(0xffB7935F);
  static final Color darkPrimary = Color(0xff141A2E);
  static final Color darkSecondary = Color(0xffFACC1D);
  static bool isDark = true;
  static ThemeData lightTheme = ThemeData(
      textTheme: TextTheme(
          bodyLarge: GoogleFonts.amiri(

              fontSize: 20.sp, fontWeight: FontWeight.w500, color: Colors.black),
          bodyMedium: TextStyle(
              fontSize: 25.sp, fontWeight: FontWeight.w700, color: Colors.black),
          titleMedium: TextStyle(
              fontSize: 27.sp, fontWeight: FontWeight.w700, color: Colors.black),
          bodySmall: GoogleFonts.lalezar(
              fontSize: 25.sp, fontWeight: FontWeight.w500, color: Colors.black),
          titleLarge: GoogleFonts.elMessiri(
              fontSize: 30.sp, fontWeight: FontWeight.bold, color: Colors.black),
          titleSmall: GoogleFonts.elMessiri(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black)),
      scaffoldBackgroundColor: Colors.transparent,
      fontFamily: GoogleFonts.elMessiri().fontFamily,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.elMessiri(
          fontSize: 35.sp,
          color: Color(0xff242424),
        ),
        centerTitle: true,
      ),
      iconTheme: IconThemeData(color: Colors.black, size: 30.sp),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff242424),
          unselectedItemColor: Colors.white,
          showUnselectedLabels: false,
          backgroundColor: lightPrimary,
          selectedIconTheme: IconThemeData(size: 32)),
      dividerTheme: DividerThemeData(thickness: 5.sp, color: Color(0xffB7935F)),
      colorScheme: ColorScheme.fromSeed(
          seedColor: lightPrimary,
          primary: lightPrimary,
          onPrimary: Colors.white,
          secondary: lightPrimary,
          onSecondary: Colors.black));
  static ThemeData darkTheme = ThemeData(
      textTheme: TextTheme(
          bodyLarge: GoogleFonts.elMessiri(
              fontSize: 22.sp, fontWeight: FontWeight.w500, color: Colors.white),
          bodyMedium: TextStyle(
              fontSize: 25.sp, fontWeight: FontWeight.w700, color: Colors.white),
          titleMedium: TextStyle(
              fontSize: 27.sp, fontWeight: FontWeight.w700, color: Colors.white),
          bodySmall: GoogleFonts.lalezar(
              fontSize: 25.sp, fontWeight: FontWeight.w500, color: Colors.white),
          titleLarge: GoogleFonts.elMessiri(
              fontSize: 30.sp, fontWeight: FontWeight.bold, color: Colors.white),
          titleSmall: GoogleFonts.elMessiri(
              fontSize: 21.sp, fontWeight: FontWeight.bold, color: Colors.white)),
      scaffoldBackgroundColor: Colors.transparent,
      fontFamily: GoogleFonts.elMessiri().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.elMessiri(
          fontSize: 35.sp,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      dividerTheme: DividerThemeData(thickness: 5, color: darkSecondary),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: darkSecondary,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        backgroundColor: darkPrimary,
      ),
      iconTheme: IconThemeData(color: Colors.white, size: 30),
      colorScheme: ColorScheme.fromSeed(
          seedColor: darkPrimary,
          primary: darkPrimary,
          onPrimary: Colors.white,
          secondary: darkSecondary,
          onSecondary: Colors.black));
}
