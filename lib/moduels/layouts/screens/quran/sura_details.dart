import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:islami/moduels/layouts/screens/quran/quran_screen.dart';
import 'package:islami/providers/sura_details_provider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/my_provider.dart';

class SuraDetails extends StatelessWidget {
  static const String routeName = "suraDetails";

  SuraDetails({super.key});

  bool isDark = AppTheme.isDark;
  Color darkPrimary = AppTheme.darkPrimary;
  Color darkSecondary = AppTheme.darkSecondary;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    var model = ModalRoute.of(context)?.settings.arguments as data;

    return ChangeNotifierProvider(
      create: (context) => SuraDetailsProvider()..readSura(model.index + 1),
      builder: (context, child) {
        var provider = Provider.of<SuraDetailsProvider>(context);
        return provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : bg_widget(
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
                    title: Text(
                      "سوره ${model.sura}",
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  body: Column(
                    children: [
                      SizedBox(height: 15.h),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final maxHeight = constraints.maxHeight;
                            final textSize = 25.sp;

                            List<List<Map<String, dynamic>>> pages =
                                paginateVersesByHeight(
                              maxWidth: constraints.maxWidth,
                              verses: provider.verses,
                              maxHeight: maxHeight,
                              textSize: textSize,
                              isDarkMode: pro.mode == ThemeMode.dark,
                            );

                            return Padding(
                              padding: EdgeInsets.all(15.sp),
                              child: PageView.builder(
                                itemCount: pages.length,
                                scrollDirection: Axis.horizontal,
                                controller: PageController(
                                  viewportFraction: 1,
                                ),
                                itemBuilder: (context, pageIndex) {
                                  final pageVerses = pages[pageIndex];

                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.all(12.sp),
                                      child: RichText(
                                        textAlign: TextAlign.justify,
                                        textDirection: TextDirection.rtl,
                                        text: TextSpan(
                                          children: [
                                            for (int i = 0;
                                                i < pageVerses.length;
                                                i++) ...[
                                              TextSpan(
                                                text:
                                                    "${pageVerses[i]['text']} ",
                                                style: GoogleFonts.amiri(
                                                  fontSize: textSize,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      pro.mode == ThemeMode.dark
                                                          ? Colors.white
                                                          : Colors.black,
                                                ),
                                              ),
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.w),
                                                  child: CircleAvatar(
                                                    backgroundColor: pro.mode ==
                                                            ThemeMode.dark
                                                        ? Colors.red
                                                            .withOpacity(0.5)
                                                        : const Color(
                                                            0xffB7935F),
                                                    radius: 14.r,
                                                    child: Text(
                                                      '${pageVerses[i]['index'] + 1}',
                                                      style: TextStyle(
                                                        color: pro.mode ==
                                                                ThemeMode.dark
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }

  List<List<Map<String, dynamic>>> paginateVersesByHeight({
    required List<String> verses,
    required double maxHeight,
    required double maxWidth,
    required double textSize,
    required bool isDarkMode,
  }) {
    List<List<Map<String, dynamic>>> pages = [];
    List<Map<String, dynamic>> currentPage = [];
    double currentHeight = 0;

    final textStyle = GoogleFonts.amiri(
      fontSize: textSize,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black,
    );

    for (int i = 0; i < verses.length; i++) {
      var verse = verses[i].trim();
      if (verse.isEmpty) continue;

      final textPainter = TextPainter(
        text: TextSpan(text: verse, style: textStyle),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.justify,
        maxLines: null,
      );
      textPainter.layout(maxWidth: maxWidth);
      double verseHeight = textPainter.height + 10;

      if (currentHeight + verseHeight > maxHeight + 5) {
        pages.add(currentPage);
        currentPage = [];
        currentHeight = 0;
      }

      currentPage.add({"text": verse, "index": i});
      currentHeight += verseHeight;
    }

    if (currentPage.isNotEmpty) {
      pages.add(currentPage);
    }

    return pages;
  }
}
