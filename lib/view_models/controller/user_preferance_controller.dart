import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/models/login/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LANGUAGE_CODE = "languageCode";
const String ENGLISH = "en";
const String GUJARATI = "gu";

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

  Future<String?> getLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      String langCode = await preferences.getString(LANGUAGE_CODE) ?? ENGLISH;
      return langCode;
    } catch (e) {
      return null;
    }
  }

  Future<Locale> setLanguage(String langCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(LANGUAGE_CODE, langCode);
    return _locale(langCode);
    // String? lang;
    // try {
    //   lang = await preferences.getString("lang");
    // } catch (e) {
    //   print(e.toString());
    // }
    // if (lang != null) {
    //   preferences.remove("lang");
    // }
    // bool isSetLang = await preferences.setString("lang", langCode);
    // return isSetLang;
  }

  Locale _locale(String langCode) {
    switch (langCode) {
      case ENGLISH:
        return Locale(ENGLISH, "US");
      case GUJARATI:
        return Locale(GUJARATI, "IN");
      default:
        return Locale(ENGLISH, "US");
    }
  }
}

UserPreferance userPreferance = UserPreferance();
