class ChangeFavoritesModel {
  bool status;
  String message;
  ChangeFavoritesModel.change(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
