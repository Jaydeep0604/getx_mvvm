import 'dart:async';

import 'package:get/get.dart';
import 'package:getx_mvvm/resources/routes/routes_name.dart';
import 'package:getx_mvvm/view_models/controller/user_preferance_controller.dart';

class SplashServices {
  UserPreferance userPreferance = UserPreferance();
  void isLogin() {
    userPreferance.getUser().then((value) {
      print(value.isLogin);

      if (value.isLogin == false || value.isLogin.toString() == 'null') {
        Timer(
          Duration(seconds: 3),
          () => Get.offNamed(RouteName.loginScreen),
        );
      } else {
        Timer(
          Duration(seconds: 3),
          () => Get.offNamed(RouteName.homeScreen),
        );
      }
    });
  }
}
