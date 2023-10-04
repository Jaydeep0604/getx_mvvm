import 'package:getx_mvvm/data/network/network_api_services.dart';
import 'package:getx_mvvm/resources/app_url/app_url.dart';

class LoginRepo {
  final apiServices = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    dynamic response = await apiServices.postApi(data, AppUrl.LOGIN_API);
    return response;
  }
}
