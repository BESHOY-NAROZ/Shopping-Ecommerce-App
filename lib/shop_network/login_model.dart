class UserLoginModel {
  bool status;
  String message;
  UserData data;

  UserLoginModel.jsonData(Map<String, dynamic> json) {
    this.status = json['status'];
    this.message = json['message'];
    this.data = json['data'] != null ? UserData.jsonData(json['data']) : null;
  }
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  String token;
  int points;
  int credit;

  UserData.jsonData(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.image = json['image'];
    this.token = json['token'];
    this.points = json['points'];
    this.credit = json['credit'];
  }
}
