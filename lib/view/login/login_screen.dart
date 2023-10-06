import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/languages/localization.dart';
import 'package:getx_mvvm/main.dart';
import 'package:getx_mvvm/resources/components/round_button_widget.dart';
import 'package:getx_mvvm/utils/utils.dart';
import 'package:getx_mvvm/view/login/language.dart';
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
        title: Text(
          "${AppLocalization.of(context)!.getTranslatedValue("login")}",
        ),
        leading: IconButton(
          onPressed: () {
            Get.to(LanguageScreen());
          },
          icon: Icon(Icons.abc),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: loginController.emailCtr.value,
                focusNode: loginController.emailFocusNode.value,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Utils.snackbar("Email", "Enter email");
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
                height: 10,
              ),
              TextFormField(
                controller: loginController.passwordCtr.value,
                focusNode: loginController.passwordFocusNode.value,
                obscureText: true,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Utils.snackbar("Password", "Enter password");
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => RoundButtonWidget(
                    title:
                        "${AppLocalization.of(context)?.getTranslatedValue("login")}",
                    isLoading: loginController.isLoading.value,
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        loginController.loginApi();
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
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
}
