import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:provider/provider.dart';

import '../../../../providers/my_provider.dart';

class TasbehScreen extends StatefulWidget {
  static const String routeName = "TasbehScreen";

  TasbehScreen({super.key});

  @override
  State<TasbehScreen> createState() => _TasbehScreenState();
}

class _TasbehScreenState extends State<TasbehScreen> {
  List<String> AzkarAfterSalah = [
    """سُبْحَانَ اللَّهِ """,
    """ سُبْحَانَ اللَّهِ وَبِحَمْدِهِ """,
    """ سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ """,
    """ سُبْحَانَ اللهِ العَظِيمِ وَبِحَمْدِهِ """,
    """ سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ الْعَظِيمِ""",
    """ لَا إِلَهَ إِلَّا اللَّهُ""",
    """ الْلَّهُ أَكْبَرُ""",
    """ سُبْحَانَ اللَّهِ ، وَالْحَمْدُ لِلَّهِ ، وَلا إِلَهَ إِلا اللَّهُ ، وَاللَّهُ أَكْبَرُ ، اللَّهُمَّ اغْفِرْ لِي ، اللَّهُمَّ ارْحَمْنِي ، اللَّهُمَّ ارْزُقْنِي.""",
    """ الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ.""",
    """ اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً. """,
    """ اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ , وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ , اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ.""",
  ];
  List<int> AzkarAfterSalahTimes = [
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100,
    100
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);

    return bg_widget(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "تسابيح",
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
                                  style: Theme.of(context).textTheme.bodyMedium,
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
