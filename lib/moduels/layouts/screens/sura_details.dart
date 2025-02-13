import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:islami/moduels/layouts/screens/quran_screen.dart';
import 'package:islami/providers/sura_details_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_provider.dart';

class SuraDetails extends StatelessWidget {
  static const String routeName = "suraDetails";

  SuraDetails({super.key});

  bool isDark = AppTheme.isDark;
  Color darkPrimary = AppTheme.darkPrimary;
  Color darkSecondary = AppTheme.darkSecondary;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    // var provider = Provider.of<SuraDetailsProvider>(context);

    var model = ModalRoute.of(context)?.settings.arguments as data;

    return ChangeNotifierProvider(
        create: (context) => SuraDetailsProvider()..readSura(model.index + 1),
        builder: (context, child) {
          var provider = Provider.of<SuraDetailsProvider>(context);
          return provider.isLoading?Center(child: CircularProgressIndicator(),):bg_widget(
            child: Scaffold(
              appBar: AppBar(
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: pro.mode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                title: Column(
                  children: [
                    Text(
                      "سوره ${model.sura}",
                      style: TextStyle(
                          fontSize: 30.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(children: [
                Text("بسم الله الرحمن الرحيم",
                    style: GoogleFonts.amiri(
                        fontSize: 30.sp, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12.sp),
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xffB7935F), width: 3.w),
                        color: pro.mode == ThemeMode.dark
                            ? darkPrimary
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffB7935F),
                            blurRadius: 15.sp,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30.r)),
                    child: SingleChildScrollView(
                      child: RichText(
                        textAlign: provider.verses.length <= 20
                            ? TextAlign.center
                            : TextAlign.justify,
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          children: [
                            for (var i = 0;
                                i <= provider.verses.length - 1;
                                i++) ...{
                             if(provider.verses[i].trim().isNotEmpty)
                               TextSpan(
                                   text: provider.verses[i].replaceAll(RegExp(r'\s+'), ' ').trim(),
                                   style: pro.mode == ThemeMode.dark
                                       ? GoogleFonts.amiri(
                                       fontSize: 25.sp,
                                       fontWeight: FontWeight.bold)
                                       : GoogleFonts.amiri(
                                       fontSize: 25.sp,
                                       fontWeight: FontWeight.bold,
                                       color: Colors.black)),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: CircleAvatar(
                                  backgroundColor: pro.mode == ThemeMode.dark
                                      ? Colors.red.withOpacity(0.5)
                                      : Color(0xffB7935F),
                                  radius: 14.r,
                                  child: Text(
                                    '${i + 1}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: pro.mode == ThemeMode.dark
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp),
                                    textScaleFactor:
                                        i.toString().length <= 2 ? 1 : .8,
                                  ),
                                ),
                              ),
                            },
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
