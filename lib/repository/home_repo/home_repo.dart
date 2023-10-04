import 'package:getx_mvvm/data/network/network_api_services.dart';
import 'package:getx_mvvm/models/home/user_list_model.dart';
import 'package:getx_mvvm/resources/app_url/app_url.dart';

class HomeRepo {
  final apiServices = NetworkApiServices();

  Future<UserListModel> homeListApi() async {
    dynamic response = await apiServices.getApi(AppUrl.USER_LIST_API);
    return UserListModel.fromJson(response);
  }
}
