import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuraDetailsProvider extends ChangeNotifier {
  List<String> verses = [];
  bool isLoading=false;

  readSura(int index) async {
    isLoading=true;
    String sura =
        await rootBundle.loadString("assets/suras/${index}.txt"); // all
    isLoading=false;

    String newSura = sura.trim();
    List<String> suraLine = newSura.split("\n"); // line
    verses = suraLine;
    notifyListeners();
  }
}
