import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/languages/localization.dart';
import 'package:getx_mvvm/main.dart';
import 'package:getx_mvvm/resources/colors/colors.dart';
import 'package:getx_mvvm/resources/components/round_button_widget.dart';
import 'package:getx_mvvm/utils/utils.dart';
import 'package:getx_mvvm/view_models/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  late Locale? locale;
  void initState() {
    locale = MyApp.getLocale(context);
    super.initState();
  }

  RelativeRect buttonMenuPosition(BuildContext context) {
    // final bool isEnglish =
    //     LocalizedApp.of(context).delegate.currentLocale.languageCode == 'en';
    final RenderBox bar = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    const Offset offset = Offset.zero;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        bar.localToGlobal(bar.size.topRight(Offset(0, -70)), ancestor: overlay),
        bar.localToGlobal(bar.size.topRight(Offset(0, -70)), ancestor: overlay),
      ),
      offset & overlay.size,
    );
    return position;
  }

  onSetLang(Locale value) {
    setState(() {
      locale = value;
    });
    MyApp.setLocale(context, locale!);
  }

  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            height: 30,
            padding: EdgeInsets.zero,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side:
                      BorderSide(color: AppColors.blueColor.withOpacity(0.5))),
              elevation: 0,
              onPressed: () {
                showMenu(
                  context: context,
                  position: buttonMenuPosition(context),
                  initialValue: locale,
                  items: [
                    PopupMenuItem<Locale>(
                      child: Text(
                        "${AppLocalization.of(context)?.getTranslatedValue("english")}",
                        style:
                            Theme.of(context).textTheme.bodyText1?.copyWith(),
                      ),
                      value: Locale('en', "EN"),
                      onTap: () {
                        onSetLang(Locale('en', "EN"));
                      },
                    ),
                    PopupMenuItem<Locale>(
                      child: Text(
                        "${AppLocalization.of(context)?.getTranslatedValue("hindi")}",
                        style:
                            Theme.of(context).textTheme.bodyText1?.copyWith(),
                      ),
                      value: Locale('hi', "IN"),
                      onTap: () {
                        onSetLang(Locale('hi', "IN"));
                      },
                    ),
                    PopupMenuItem<Locale>(
                      child: Text(
                        "${AppLocalization.of(context)?.getTranslatedValue("gujarati")}",
                        style:
                            Theme.of(context).textTheme.bodyText1?.copyWith(),
                      ),
                      onTap: () {
                        onSetLang(Locale('gu', "IN"));
                      },
                      value: Locale('gu', "IN"),
                    ),
                    PopupMenuItem<Locale>(
                      child: Text(
                        "${AppLocalization.of(context)?.getTranslatedValue("spanish")}",
                        style:
                            Theme.of(context).textTheme.bodyText1?.copyWith(),
                      ),
                      onTap: () {
                        onSetLang(Locale('es', "ES"));
                      },
                      value: Locale('es', "ES"),
                    )
                  ],
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.language,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${AppLocalization.of(context)?.getTranslatedValue("${locale?.languageCode == 'en' ? 'english' : locale?.languageCode == 'hi' ? 'hindi' : locale?.languageCode == 'gu' ? 'gujarati' : locale?.languageCode == 'es' ? 'spanish' : 'english'}")}",
                    style: TextStyle(fontSize: 14),
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                ),
                Text(
                  "${AppLocalization.of(context)!.getTranslatedValue("login")}",
                  style: TextStyle(
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue("email")}*",
                  style: TextStyle(
                      color: AppColors.blackColor.withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: loginController.emailCtr.value,
                  focusNode: loginController.emailFocusNode.value,
                  decoration: InputDecoration(
                    hintText:
                        "${AppLocalization.of(context)?.getTranslatedValue("email")}",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Utils.snackbar(
                          "${AppLocalization.of(context)?.getTranslatedValue("email")}*",
                          "${AppLocalization.of(context)?.getTranslatedValue("enter_email")}");
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    Utils.feildFocusChange(
                        context,
                        loginController.emailFocusNode.value,
                        loginController.passwordFocusNode.value);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${AppLocalization.of(context)?.getTranslatedValue("password")}*",
                  style: TextStyle(
                      color: AppColors.blackColor.withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: loginController.passwordCtr.value,
                  focusNode: loginController.passwordFocusNode.value,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText:
                        "${AppLocalization.of(context)?.getTranslatedValue("password")}*",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Utils.snackbar(
                          "${AppLocalization.of(context)?.getTranslatedValue("password")}*",
                          "${AppLocalization.of(context)?.getTranslatedValue("enter_password")}*");
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(
                  () => RoundButtonWidget(
                    title:
                        "${AppLocalization.of(context)?.getTranslatedValue("login")}",
                    isLoading: loginController.isLoading.value,
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        loginController.loginApi();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
