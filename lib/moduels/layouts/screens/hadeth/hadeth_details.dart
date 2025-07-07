import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:islami/moduels/hadeth_models.dart';
import 'package:provider/provider.dart';

import '../../../../providers/my_provider.dart';

class HadethDetails extends StatefulWidget {
  static const String routeName = "hadethDetails";

  HadethDetails({super.key});

  @override
  State<HadethDetails> createState() => _HadethDetailsState();
}

class _HadethDetailsState extends State<HadethDetails> {
  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as hadethModel;
    var pro = Provider.of<MyProvider>(context);

    return bg_widget(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
                setState(() {});
              },
              child: Icon(
                Icons.arrow_back,
                color: pro.mode == ThemeMode.dark ? Colors.white : Colors.black,
              )),
          title: Column(
            children: [
              Text(
                "${model.title}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20.sp),
          margin: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(
              color:
                  pro.mode == ThemeMode.dark ? Color(0xff141A2E) : Colors.white,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffB7935F),
                  blurRadius: 5.sp,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              border: Border.all(color: Color(0xffB7935F), width: 3.w)),
          child: ListView.builder(
            itemCount: model.content.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(
                    // textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    "${model.content[index]}",
                    style: pro.mode == ThemeMode.dark
                        ? Theme.of(context).textTheme.bodyLarge
                        : Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
