class ProfileModel {
  bool status;
  String message;
  ProfileData data;

  ProfileModel.jsonData(Map<String, dynamic> json) {
    this.status = json['status'];
    this.message = json['message'];
    this.data = ProfileData.jsonData(json['data']);
  }
}

class ProfileData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  String token;
  int points;
  int credit;

  ProfileData.jsonData(Map<String, dynamic> json) {
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
