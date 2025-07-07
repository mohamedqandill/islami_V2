import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:provider/provider.dart';

import '../../../../providers/my_provider.dart';

class QuranDoaa extends StatefulWidget {
  static const String routeName = "QuranDoaa";

  QuranDoaa({super.key});

  @override
  State<QuranDoaa> createState() => _QuranDoaaState();
}

class _QuranDoaaState extends State<QuranDoaa> {
  List<String> AzkarAfterSalah = [
    """"رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ". [البقرة - 201]. """,
    """ "رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ". [البقرة - 250].""",
    """"رَبَّنَا لاَ تُؤَاخِذْنَا إِن نَّسِينَا أَوْ أَخْطَأْنَا رَبَّنَا وَلاَ تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا رَبَّنَا وَلاَ تُحَمِّلْنَا مَا لاَ طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا أَنتَ مَوْلاَنَا فَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ". [البقرة - 286]. """,
    """"رَبَّنَا لاَ تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً إِنَّكَ أَنتَ الْوَهَّابُ". [آل عمران - 8]. """,
    """"رَبَّنَا إِنَّنَا آمَنَّا فَاغْفِرْ لَنَا ذُنُوبَنَا وَقِنَا عَذَابَ النَّارِ". [آل عمران - 16]. """,
    """"رَبِّ هَبْ لِي مِن لَّدُنْكَ ذُرِّيَّةً طَيِّبَةً إِنَّكَ سَمِيعُ الدُّعَاء". [آل عمران - 38]. """,
    """ "رَبَّنَا آمَنَّا بِمَا أَنزَلْتَ وَاتَّبَعْنَا الرَّسُولَ فَاكْتُبْنَا مَعَ الشَّاهِدِينَ". [آل عمران - 53].""",
    """ "ربَّنَا اغْفِرْ لَنَا ذُنُوبَنَا وَإِسْرَافَنَا فِي أَمْرِنَا وَثَبِّتْ أَقْدَامَنَا وانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَِ". [آل عمران - 147].""",
    """ "رَبَّنَا مَا خَلَقْتَ هَذا بَاطِلاً سُبْحَانَكَ فَقِنَا عَذَابَ النَّارِ رَبَّنَا إِنَّكَ مَن تُدْخِلِ النَّارَ فَقَدْ أَخْزَيْتَهُ وَمَا لِلظَّالِمِينَ مِنْ أَنصَارٍ رَّبَّنَا إِنَّنَا سَمِعْنَا مُنَادِيًا يُنَادِي لِلإِيمَانِ أَنْ آمِنُواْ بِرَبِّكُمْ فَآمَنَّا رَبَّنَا فَاغْفِرْ لَنَا ذُنُوبَنَا وَكَفِّرْ عَنَّا سَيِّئَاتِنَا وَتَوَفَّنَا مَعَ الأبْرَارِ رَبَّنَا وَآتِنَا مَا وَعَدتَّنَا عَلَى رُسُلِكَ وَلاَ تُخْزِنَا يَوْمَ الْقِيَامَةِ إِنَّكَ لاَ تُخْلِفُ الْمِيعَادَ". [آل عمران -  191-194].""",
    """ "رَبَّنَا ظَلَمْنَا أَنفُسَنَا وَإِن لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ الْخَاسِرِينَ". [الأعراف - 23].""",
    """ "رَبَّنَا لاَ تَجْعَلْنَا مَعَ الْقَوْمِ الظَّالِمِينَ". [الأعراف - 47].""",
    """"رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَتَوَفَّنَا مُسْلِمِينَ". [الأعراف - 126]. """,
  ];
  List<int> AzkarAfterSalahTimes = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);

    return bg_widget(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "الادعيه القرأنيه",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: Icon(
              Icons.arrow_back,
              color: pro.mode == ThemeMode.dark ? Colors.white : Colors.black,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: AzkarAfterSalah.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        if (AzkarAfterSalahTimes[index] > 0) {
                          AzkarAfterSalahTimes[index]--;
                          setState(() {});
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.0.sp),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(12.sp),
                            width: double.infinity,
                            // height: 200,
                            decoration: BoxDecoration(
                              color: pro.mode == ThemeMode.dark
                                  ? AzkarAfterSalahTimes[index] == 0
                                      ? Colors.grey
                                      : Color(0xff141A2E)
                                  : AzkarAfterSalahTimes[index] == 0
                                      ? Colors.grey
                                      : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: pro.mode == ThemeMode.dark
                                      ? AzkarAfterSalahTimes[index] == 0
                                          ? Colors.grey
                                          : Colors.red
                                      : Color(0xffB7935F),
                                  blurRadius: 5.sp,
                                  spreadRadius: 1.sp,
                                  // blurStyle: BlurStyle.outer,
                                ),
                              ],
                              border: pro.mode == ThemeMode.dark
                                  ? Border.all(
                                      color: AzkarAfterSalahTimes == 0
                                          ? Colors.grey
                                          : Colors.red,
                                      width: 1.w)
                                  : Border.all(
                                      color: AzkarAfterSalahTimes == 0
                                          ? Colors.grey
                                          : Color(0xffB7935F),
                                      width: 3),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50.r),
                                bottomLeft: Radius.circular(20.r),
                                topLeft: Radius.circular(40.r),
                                topRight: Radius.circular(20.r),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${AzkarAfterSalah[index]}",
                                  textDirection: TextDirection.rtl,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Divider(
                                  thickness: 1.sp,
                                  indent: 20.sp,
                                  endIndent: 20.sp,
                                ),
                                Text(" ${AzkarAfterSalahTimes[index]} مرات  ")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
