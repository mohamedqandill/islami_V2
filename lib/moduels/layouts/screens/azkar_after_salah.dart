import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_provider.dart';

class AzkarAfterSalah extends StatefulWidget {
  static const String routeName = "AzkarAfterSalah";

  AzkarAfterSalah({super.key});

  @override
  State<AzkarAfterSalah> createState() => _AzkarAfterSalahState();
}

class _AzkarAfterSalahState extends State<AzkarAfterSalah> {
  List<String> AzkarAfterSalah = [
    """أَسْـتَغْفِرُ الله، أَسْـتَغْفِرُ الله، أَسْـتَغْفِرُ الله.
اللّهُـمَّ أَنْـتَ السَّلامُ ، وَمِـنْكَ السَّلام ، تَبارَكْتَ يا ذا الجَـلالِ وَالإِكْـرام  """,
    """لا إلهَ إلاّ اللّهُ وحدَهُ لا شريكَ لهُ، لهُ المُـلْكُ ولهُ الحَمْد، وهوَ على كلّ شَيءٍ قَدير، اللّهُـمَّ لا مانِعَ لِما أَعْطَـيْت، وَلا مُعْطِـيَ لِما مَنَـعْت، وَلا يَنْفَـعُ ذا الجَـدِّ مِنْـكَ الجَـد. """,
    """ لا إلهَ إلاّ اللّه, وحدَهُ لا شريكَ لهُ، لهُ الملكُ ولهُ الحَمد، وهوَ على كلّ شيءٍ قدير، لا حَـوْلَ وَلا قـوَّةَ إِلاّ بِاللهِ، لا إلهَ إلاّ اللّـه، وَلا نَعْـبُـدُ إِلاّ إيّـاه, لَهُ النِّعْـمَةُ وَلَهُ الفَضْل وَلَهُ الثَّـناءُ الحَـسَن، لا إلهَ إلاّ اللّهُ مخْلِصـينَ لَـهُ الدِّينَ وَلَوْ كَـرِهَ الكـافِرون.""",
    """ سُـبْحانَ اللهِ، والحَمْـدُ لله ، واللهُ أكْـبَر.""",
    """ لا إلهَ إلاّ اللّهُ وَحْـدَهُ لا شريكَ لهُ، لهُ الملكُ ولهُ الحَمْد، وهُوَ على كُلّ شَيءٍ قَـدير.""",
    """ أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ
اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ. [آية الكرسى - البقرة 255]""",
    """ اللّهُـمَّ إِنِّـي أَسْأَلُـكَ عِلْمـاً نافِعـاً وَرِزْقـاً طَيِّـباً ، وَعَمَـلاً مُتَقَـبَّلاً. """,
    """ اللَّهُمَّ أَجِرْنِي مِنْ النَّار.""",
    """ اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ.""",

  ];
  List<int> AzkarAfterSalahTimes=[1,1,1,33,3,1,10,1,7,1];
  int index = 0;


  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);


    return bg_widget(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "اذكار بعد الصلاه",
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
                            if (AzkarAfterSalahTimes [index]> 0) {
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
