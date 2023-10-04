import 'package:get/get.dart';
import 'package:getx_mvvm/data/response/status.dart';
import 'package:getx_mvvm/models/home/user_list_model.dart';
import 'package:getx_mvvm/repository/home_repo/home_repo.dart';

class HomeController extends GetxController {
  final _repo = HomeRepo();
  final RxRequestStatus = Status.LOADING.obs;
  final userList = UserListModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => RxRequestStatus.value = _value;
  void setUserList(UserListModel _value) => userList.value = _value;
  void setError(String _value) => error.value = _value;

  void userListApi() {
    // setRxRequestStatus(Status.LOADING);
    _repo.homeListApi().then((value) {
      setRxRequestStatus(Status.COMPLATED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      print(error);
      print(stackTrace);
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshUserListApi() {
    setRxRequestStatus(Status.LOADING);
    _repo.homeListApi().then((value) {
      setRxRequestStatus(Status.COMPLATED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      print(error);
      print(stackTrace);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
