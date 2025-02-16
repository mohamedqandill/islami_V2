import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:islami/main.dart';
import 'package:islami/moduels/layouts/screens/reciter_sura_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_provider.dart';

class ReciterScreen extends StatelessWidget {
  const ReciterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return bg_widget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: pro.getAllReciter(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 30,
                    ),
                    Text(snapshot.error.toString()),
                  ],
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: pro.reciterModel.recitations!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                                print(pro.reciterModel.recitations![index].id);
                            return ReciterSuraScreen(
                              id: pro.reciterModel.recitations![index].id);
                          },)
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.0.sp),
                          child: Column(
                            children: [
                              Row(

                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Expanded(
                                    child: Text(
                                      "${context.locale == Locale("ar") ? pro
                                          .reciterModel.recitations![index]
                                          .translatedName!.name : pro
                                          .reciterModel.recitations![index]
                                          .reciterName}",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),

                                  Text(
                                    "${pro.reciterModel.recitations?[index]
                                        .style ?? ""}",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleSmall,
                                  ),
                                ],
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
