class LoginResponseModel {
  String? token;
  bool? isLogin;

  LoginResponseModel({this.token, this.isLogin});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isLogin = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['isLogin'] = this.isLogin;
    return data;
  }
}
