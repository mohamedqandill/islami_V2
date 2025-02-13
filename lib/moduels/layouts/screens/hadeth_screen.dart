import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islami/main.dart';
import 'package:islami/moduels/layouts/screens/hadeth_details.dart';

import '../../hadeth_models.dart';

class HadethScreen extends StatefulWidget {
  HadethScreen({super.key});

  @override
  State<HadethScreen> createState() => _HadethScreenState();
}

class _HadethScreenState extends State<HadethScreen> {
  List<hadethModel> content = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readHadeth();
  }

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) {
      readHadeth();
    }
    return Column(
      children: [
        Image(
          image: AssetImage("assets/images/hadith_header.png"),
          width: 220.w,
        ),

        // SizedBox(height: 15,),
        Expanded(
          child: ListView.separated(
            itemCount: content.length ~/ 2,
            separatorBuilder: (context, index) => const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Divider(
                  thickness: 2,
                  indent: 30,
                  endIndent: 30,
                )),
              ],
            ),
            itemBuilder: (context, index) {
              return InkWell(
                child: Text(
                    textAlign: TextAlign.center,
                    "${content[index].title}",
                    style: Theme.of(context).textTheme.bodySmall),
                onTap: () {
                  Navigator.pushNamed(context, HadethDetails.routeName,
                      arguments: content[index]);
                },
              );
            },
          ),
        )
      ],
    );
  }

  Future<void> readHadeth() async {
    String hadeth = await rootBundle.loadString("assets/hadeth/ahadeth.txt");
    List<String> hadethDetail = hadeth.split("#");
    for (int i = 0; i < hadethDetail.length ; i++) {
      String hadethOne = hadethDetail[i];
      List<String> hadethLines = hadethOne.trim().split("\n");
      String hadethTitle = hadethLines[0];

      hadethLines.removeAt(0);
      List<String> hadethContent = hadethLines;
      hadethModel data = hadethModel(hadethTitle, hadethContent);
      content.add(data);
      setState(() {});
    }
  }
}
