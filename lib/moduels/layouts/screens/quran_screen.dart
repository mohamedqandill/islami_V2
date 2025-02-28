import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/main.dart';
import 'package:islami/moduels/layouts/screens/sura_details.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_provider.dart';

class QuranScreen extends StatelessWidget {
  QuranScreen({super.key});

  List<String> arabicAuranSuras = [
    "الفاتحه",
    "البقرة",
    "آل عمران",
    "النساء",
    "المائدة",
    "الأنعام",
    "الأعراف",
    "الأنفال",
    "التوبة",
    "يونس",
    "هود",
    "يوسف",
    "الرعد",
    "إبراهيم",
    "الحجر",
    "النحل",
    "الإسراء",
    "الكهف",
    "مريم",
    "طه",
    "الأنبياء",
    "الحج",
    "المؤمنون",
    "النّور",
    "الفرقان",
    "الشعراء",
    "النّمل",
    "القصص",
    "العنكبوت",
    "الرّوم",
    "لقمان",
    "السجدة",
    "الأحزاب",
    "سبأ",
    "فاطر",
    "يس",
    "الصافات",
    "ص",
    "الزمر",
    "غافر",
    "فصّلت",
    "الشورى",
    "الزخرف",
    "الدّخان",
    "الجاثية",
    "الأحقاف",
    "محمد",
    "الفتح",
    "الحجرات",
    "ق",
    "الذاريات",
    "الطور",
    "النجم",
    "القمر",
    "الرحمن",
    "الواقعة",
    "الحديد",
    "المجادلة",
    "الحشر",
    "الممتحنة",
    "الصف",
    "الجمعة",
    "المنافقون",
    "التغابن",
    "الطلاق",
    "التحريم",
    "الملك",
    "القلم",
    "الحاقة",
    "المعارج",
    "نوح",
    "الجن",
    "المزّمّل",
    "المدّثر",
    "القيامة",
    "الإنسان",
    "المرسلات",
    "النبأ",
    "النازعات",
    "عبس",
    "التكوير",
    "الإنفطار",
    "المطفّفين",
    "الإنشقاق",
    "البروج",
    "الطارق",
    "الأعلى",
    "الغاشية",
    "الفجر",
    "البلد",
    "الشمس",
    "الليل",
    "الضحى",
    "الشرح",
    "التين",
    "العلق",
    "القدر",
    "البينة",
    "الزلزلة",
    "العاديات",
    "القارعة",
    "التكاثر",
    "العصر",
    "الهمزة",
    "الفيل",
    "قريش",
    "الماعون",
    "الكوثر",
    "الكافرون",
    "النصر",
    "المسد",
    "الإخلاص",
    "الفلق",
    "الناس"
  ];
  List<String> AyaNumber = [
    '7',
    '286',
    '200',
    '176',
    '120',
    '165',
    '206',
    '75',
    '129',
    '109',
    '123',
    '111',
    '43',
    '52',
    '99',
    '128',
    '111',
    '110',
    '98',
    '135',
    '112',
    '78',
    '118',
    '64',
    '77',
    '227',
    '93',
    '88',
    '69',
    '60',
    '34',
    '30',
    '73',
    '54',
    '45',
    '83',
    '182',
    '88',
    '75',
    '85',
    '54',
    '53',
    '89',
    '59',
    '37',
    '35',
    '38',
    '29',
    '18',
    '45',
    '60',
    '49',
    '62',
    '55',
    '78',
    '96',
    '29',
    '22',
    '24',
    '13',
    '14',
    '11',
    '11',
    '18',
    '12',
    '12',
    '30',
    '52',
    '52',
    '44',
    '28',
    '28',
    '20',
    '56',
    '40',
    '31',
    '50',
    '40',
    '46',
    '42',
    '29',
    '19',
    '36',
    '25',
    '22',
    '17',
    '19',
    '26',
    '30',
    '20',
    '15',
    '21',
    '11',
    '8',
    '5',
    '19',
    '5',
    '8',
    '8',
    '11',
    '11',
    '8',
    '3',
    '9',
    '5',
    '4',
    '6',
    '3',
    '6',
    '3',
    '5',
    '4',
    '5',
    '6'
  ];

  @override
  Widget build(BuildContext context) {
    // bool isDark = AppTheme.isDark;
    var pro = Provider.of<MyProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image(
              image: AssetImage("assets/images/quran_header_icn.png"),
              width: 120.w,
            ),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    hintText: "Search...",
                    onChanged: (query) {
                      controller.openView();
                    },
                    onTap: () {
                      controller.openView();
                    },
                  );
                },
                suggestionsBuilder: (BuildContext context, SearchController controller) {
                  final query = controller.text.trim().toLowerCase();

                  if (query.isEmpty) {
                    return []; // لا تُظهر اقتراحات عندما يكون البحث فارغًا
                  }

                  final List<Map<String, dynamic>> filteredItems = [];

                  for (int i = 0; i < arabicAuranSuras.length; i++) {
                    if (arabicAuranSuras[i].toLowerCase().contains(query)) {
                      filteredItems.add({
                        "index": i,
                        "sura": arabicAuranSuras[i],
                        "ayaCount": AyaNumber[i]
                      });
                    }
                  }

                  return [
                    Material(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return Container(
                            margin: EdgeInsets.all(8.sp),
                            padding: EdgeInsets.only(top: 4.sp),
                            alignment: Alignment.center,
                            width: double.infinity,
                            // height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50.r),
                                  bottomLeft: Radius.circular(20.r),
                                  topLeft: Radius.circular(45.r),
                                  topRight: Radius.circular(38.r),
                                ),
                                border: Border.all(
                                    color: pro.mode == ThemeMode.dark
                                        ? Color(0xffFACC1D)
                                        : Color(0xffB7935F),
                                    width: 1),
                                color: pro.mode == ThemeMode.dark
                                    ? Color(0xff141A2E)
                                    : Color(0xffB7935F),
                                boxShadow: [
                                  BoxShadow(
                                      color: pro.mode == ThemeMode.dark
                                          ? Color(0xffFACC1D)
                                          : Colors.amberAccent,
                                      spreadRadius: 2,
                                      blurRadius: 5)
                                ]

                              // gradient: LinearGradient(
                              //  // colors: isDark?[Color(0xffFACC1D).withOpacity(0.7),Colors.grey.withOpacity(0.8).withOpacity(0.9)]:[Color(0xffB7935F),Colors.grey.withOpacity(0.9)],
                              //   begin: Alignment.center,
                              //   end: Alignment.bottomLeft,
                              // )

                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            textAlign: TextAlign.center,
                                            "${item["sura"]}",
                                            style:
                                            Theme.of(context).textTheme.bodyMedium),
                                      ),
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "${item["ayaCount"]}",
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      SuraDetails.routeName,
                                      arguments:
                                          data(item["index"], item["sura"]),
                                    );
                                  },
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Container(
                                //
                                //         child: Icon(Icons.star,size: 20,),
                                //       margin: EdgeInsets.only(left: 30),
                                //     ),
                                //     Expanded(child: Divider(indent: 0,endIndent: 0,thickness: 5,color: Color(0xffB7935F),)),
                                //     Container(
                                //
                                //         child: Icon(Icons.star,size: 20,),
                                //     margin: EdgeInsets.only(right: 30),
                                //     ),
                                //
                                //   ],
                                // ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          );

                          //   ListTile(
                          //   title: Text(
                          //     item["sura"],
                          //     textAlign: TextAlign.center,
                          //     style: Theme.of(context).textTheme.bodyMedium,
                          //   ),
                          //   subtitle: Text(
                          //     "عدد الآيات: ${item["ayaCount"]}",
                          //     textAlign: TextAlign.center,
                          //   ),
                          //   onTap: () {
                          //     Navigator.pushNamed(
                          //       context,
                          //       SuraDetails.routeName,
                          //       arguments: data(item["index"], item["sura"]),
                          //     );
                          //   },
                          // );
                        },
                      ),
                    ),
                  ];
                },
              ),
            ),

            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "suraName".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text("suraNum".tr(),
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 114,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8.sp),
                    padding: EdgeInsets.only(top: 4.sp),
                    alignment: Alignment.center,
                    width: double.infinity,
                    // height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50.r),
                          bottomLeft: Radius.circular(20.r),
                          topLeft: Radius.circular(45.r),
                          topRight: Radius.circular(38.r),
                        ),
                        border: Border.all(
                            color: pro.mode == ThemeMode.dark
                                ? Color(0xffFACC1D)
                                : Color(0xffB7935F),
                            width: 1),
                        color: pro.mode == ThemeMode.dark
                            ? Color(0xff141A2E)
                            : Color(0xffB7935F),
                        boxShadow: [
                          BoxShadow(
                              color: pro.mode == ThemeMode.dark
                                  ? Color(0xffFACC1D)
                                  : Colors.amberAccent,
                              spreadRadius: 2,
                              blurRadius: 5)
                        ]

                        // gradient: LinearGradient(
                        //  // colors: isDark?[Color(0xffFACC1D).withOpacity(0.7),Colors.grey.withOpacity(0.8).withOpacity(0.9)]:[Color(0xffB7935F),Colors.grey.withOpacity(0.9)],
                        //   begin: Alignment.center,
                        //   end: Alignment.bottomLeft,
                        // )

                        ),
                    child: Column(
                      children: [
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    "${arabicAuranSuras[index]}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                              Expanded(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "${AyaNumber[index]}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, SuraDetails.routeName,
                                arguments:
                                    data(index, arabicAuranSuras[index]));
                          },
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //
                        //         child: Icon(Icons.star,size: 20,),
                        //       margin: EdgeInsets.only(left: 30),
                        //     ),
                        //     Expanded(child: Divider(indent: 0,endIndent: 0,thickness: 5,color: Color(0xffB7935F),)),
                        //     Container(
                        //
                        //         child: Icon(Icons.star,size: 20,),
                        //     margin: EdgeInsets.only(right: 30),
                        //     ),
                        //
                        //   ],
                        // ),
                        SizedBox(
                          height: 20.h,
                        ),
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
}

class data {
  int index;
  String sura;

  data(this.index, this.sura);
}
