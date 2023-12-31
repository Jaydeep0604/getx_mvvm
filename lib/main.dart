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
  late AppTranslator appTranslator;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userPreferance.getLanguage().then((locale) {
      if (locale != null) {
        setState(() {
          _locale = Locale(locale);
          appTranslator = AppTranslator(locale: _locale!);
        });
        print(appTranslator.locale);
        print("this locale is $locale");
      } else {
        print("Stored language is null. Using default language.");
        setState(() {
          _locale = Locale('en', 'US'); // Set a default locale.
          appTranslator = AppTranslator(locale: _locale!);
        });
      }
    });
  }

  void setLang() async {
    final lang = await userPreferance.getLanguage();
    if (lang != null) {
      if (lang == "en") {
        _locale = Locale('en', "US");
      } else if (lang == 'gu') {
        _locale = Locale('gu', "IN");
      } else if (lang == 'hi') {
        _locale = Locale('hi', "IN");
      }else if (lang == 'es') {
        _locale = Locale('es', "ES");
      }
      appTranslator = AppTranslator(locale: _locale!);
      print("first else");
    } else {
      appTranslator = AppTranslator(locale: _locale!);
      print("last else");
    }
  }

  void setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
    });
    appTranslator = await AppTranslator(locale: _locale!);
    print("new locale is ${appTranslator.locale}");
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
        Locale('en', 'US'),
        Locale('gu', 'IN'),
        Locale('hi', 'IN'),
        Locale('es', "ES"),
      ],
      locale: _locale,
    );
  }
}
