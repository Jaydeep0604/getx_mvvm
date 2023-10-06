import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';

class AppTranslator {
  GoogleTranslator _translator = GoogleTranslator();

  static final AppTranslator instance = AppTranslator._internal();
  AppTranslator._internal();

  factory AppTranslator({
    required Locale locale,
  }) {
    instance.locale = locale;

    return instance;
  }

  Locale? locale;

  Future<String> translate(String name) async {
    try {
      Translation tr =
          await _translator.translate(name, to: locale?.languageCode ?? "en");
      return tr.text;
    } catch (e) {
      return name;
    }
  }
}



// class Test  {
//   String name = "i am ";

//   Future<String> get getName async => translate(name);
// }
