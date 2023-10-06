import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/languages/localization.dart';
import 'package:getx_mvvm/resources/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:getx_mvvm/services/app_translator.dart';
import 'package:getx_mvvm/view_models/controller/user_preferance_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? locale = await userPreferance.getLanguage();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    userPreferance.setLanguage(newLocale.languageCode);
    _MyAppState? state = context.findRootAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  State<MyApp> createState() => _MyAppState();
  static Locale? getLocale(BuildContext context) {
    _MyAppState? state = context.findRootAncestorStateOfType<_MyAppState>();
    return state?._locale;
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  // Locale _locale = Locale('gu', 'IN');
  // late AppTranslator translator;

  @override
  void didChangeDependencies() {
    userPreferance.getLanguage().then((locale) {
      setState(() {
        Locale(locale!);
      });

      print("this is locale $locale");
    });

    super.didChangeDependencies();
  }

  // void setLang() async {
  //   final lang = await userPreferance.getLanguage();
  //   if (lang != null) {
  //     if (lang == "en") {
  //       _locale = Locale('en', "US");
  //     } else if (lang == 'gu') {
  //       _locale = Locale('gu', "IN");
  //     }
  //     // translator = AppTranslator(locale: _locale!);
  //   } else {
  //     // translator = AppTranslator(locale: _locale!);
  //   }
  // }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppRoutes.appRoutes(),
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale(
          'en',
        ),
        Locale(
          'gu',
        ),
      ],
      locale: _locale,
    );
  }
}
