import 'package:flutter/material.dart';
import 'package:getx_mvvm/languages/localization.dart';
import 'package:getx_mvvm/main.dart';
import 'package:getx_mvvm/resources/colors/colors.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  Locale? _locale;

  void didChangeDependencies() {
    super.didChangeDependencies();
    // userPreferance.getLanguage().then((locale) {
    //   setState(() {
    //     _locale = Locale(locale!);
    //     print(_locale);
    //     print(locale);
    //   });
    // });

    _locale = MyApp.getLocale(context) ?? Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalization.of(context)?.getTranslatedValue('language') ??
                'Language'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _locale = Locale("en");
                });
                MyApp.setLocale(context, _locale as Locale);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffEFEFEF),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.language)),
                    Expanded(
                      child: Text(
                        "${AppLocalization.of(context)?.getTranslatedValue('english')}",
                        // style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Radio(
                      activeColor: AppColors.blueColor,
                      value: Locale("en"),
                      groupValue: _locale,
                      onChanged: (language) async {
                        if (language != null) {
                          MyApp.setLocale(context, _locale as Locale);
                        }
                        setState(() {
                          _locale = language as Locale;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _locale = Locale("gu");
                });
                MyApp.setLocale(context, _locale as Locale);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffEFEFEF),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.language)),
                    Expanded(
                      child: Text(
                        "${AppLocalization.of(context)?.getTranslatedValue('gujarati')}",
                        // style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Radio(
                        activeColor: AppColors.blueColor,
                        value: Locale("gu"),
                        groupValue: _locale,
                        onChanged: (language) async {
                          setState(() {
                            _locale = language as Locale;
                          });
                          if (language != null) {
                            MyApp.setLocale(context, _locale as Locale);
                          }
                        })
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
