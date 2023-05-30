//create a class that will read the json file and return a map
import 'dart:convert';

import 'package:flutter/services.dart';

abstract class TranslationsAssetsReader {
  static Map<String, String>? fr;
  static Map<String, String>? en;
  static Future<void> initialize() async {
    //read the json file and return a map
    final responseAR = await rootBundle.loadString('assets/translations/language_fr.json');
    final responseEN = await rootBundle.loadString('assets/translations/language_en.json');
    fr = Map<String, String>.from(json.decode(responseAR));
    en = Map<String, String>.from(json.decode(responseEN));
  }
}
