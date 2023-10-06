import 'package:flutter/material.dart';
import 'package:getx_mvvm/languages/localization.dart';
import 'package:getx_mvvm/main.dart';
import 'package:getx_mvvm/view_models/controller/user_preferance_controller.dart';

import '../../resources/colors/colors.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late Locale? locale;

  @override
  void initState() {
    super.initState();
    getLocale();
  }

  getLocale() {
    locale = MyApp.getLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalization.of(context)?.getTranslatedValue('language') ??
                'Language'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                locale = Locale("en", "US");
              });
              MyApp.setLocale(context, locale as Locale);
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
                      value: Locale("en", "US"),
                      groupValue: locale,
                      onChanged: (language) async {
                        if (language != null) {
                          Locale _locale = await userPreferance
                              .setLanguage(language.languageCode);
                          MyApp.setLocale(context, _locale);
                        }
                        // setState(() {
                        //   locale = language as Locale;
                        // });
                      })
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
                locale = Locale("gu", "IN");
              });
              MyApp.setLocale(context, locale as Locale);
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
                      value: Locale("gu", "IN"),
                      groupValue: locale,
                      onChanged: (language) async {
                        // setState(() {
                        //   locale = language as Locale;
                        // });
                        if (language != null) {
                          Locale _locale = await userPreferance
                              .setLanguage(language.languageCode);
                          MyApp.setLocale(context, _locale);
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
    );
  }
}
