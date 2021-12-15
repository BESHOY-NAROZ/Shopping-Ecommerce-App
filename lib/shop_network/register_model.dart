class RegisterModel {
  bool status;
  String message;
  RegisterData data;
  RegisterModel.data(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = RegisterData.data(json['data']);
  }
}

class RegisterData {
  String name;
  String phone;
  String email;
  String token;

  RegisterData.data(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    token = json['token'];
  }
}
