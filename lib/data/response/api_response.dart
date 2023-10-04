import 'package:getx_mvvm/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  ApiResponse(this.status, this.data, this.message);
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.complated() : status = Status.COMPLATED;
  ApiResponse.error() : status = Status.ERROR;
  @override
  String toString() {
    return "status : $status \n Message : $message \n Data : $data";
  }
}
