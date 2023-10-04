import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:getx_mvvm/data/app_exceptions.dart';
import 'package:getx_mvvm/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException();
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    // if (kDebugMode) {
    //   print(url);
    //   print(data);
    // }
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    print(response.body.toString());
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        // print(responseJson);
        return responseJson;

      default:
        throw FetchDataException(
          'Error occoured while communicating with server' +
              response.statusCode.toString(),
        );
    }
  }
}
