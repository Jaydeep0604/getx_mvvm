import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/models/login/login_response_model.dart';
import 'package:getx_mvvm/repository/login_repo/login_repo.dart';
import 'package:getx_mvvm/resources/routes/routes_name.dart';
import 'package:getx_mvvm/utils/utils.dart';
import 'package:getx_mvvm/view_models/controller/user_preferance_controller.dart';

class LoginController extends GetxController {
  final repo = LoginRepo();

  UserPreferance userPreferance = UserPreferance();

  final emailCtr = TextEditingController(text: "eve.holt@reqres.in").obs;
  final passwordCtr = TextEditingController(text: "cityslicka").obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool isLoading = false.obs;

  void loginApi() {
    isLoading.value = true;
    Map data = {
      'email': emailCtr.value.text,
      'password': passwordCtr.value.text,
    };
    repo.loginApi(data).then((value) {
      isLoading.value = false;
      if (value['error'] == 'user not found') {
        Utils.snackbar('Login', value['error']);
      } else {
        LoginResponseModel loginResponseModel =
            LoginResponseModel(token: value['token'], isLogin: true);

        userPreferance.saveUser(loginResponseModel).then((value) {
          Get.toNamed(RouteName.homeScreen);
        }).onError((error, stackTrace) {});
        Utils.snackbar('Login', "Login successfull",);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      print(error.toString());
      Utils.snackbar('error', error.toString());
    });
  }
}
