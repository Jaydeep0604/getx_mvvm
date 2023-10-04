import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          "Login",
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
                    title: "Login",
                    isLoading: loginController.isLoading.value,
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      if (formKey.currentState!.validate() ?? false) {
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
}
