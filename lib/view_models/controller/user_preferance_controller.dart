import 'package:get/get.dart';
import 'package:getx_mvvm/models/login/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferance extends GetxController {
  Future<bool> saveUser(LoginResponseModel responseModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", responseModel.token.toString());
    preferences.setBool("isLogin", responseModel.isLogin!);
    return true;
  }

  Future<LoginResponseModel> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    bool? isLogin = preferences.getBool("isLogin");
    return LoginResponseModel(
      token: token,
      isLogin: isLogin,
    );
  }

  Future<bool> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    return true;
  }
}
