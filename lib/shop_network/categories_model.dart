class CategoriesModel {
  bool status;
  String message;
  CategoriesData data;
  CategoriesModel.categories(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = CategoriesData.categories(json['data']);
  }
}

class CategoriesData {
  List<DataData> data = [];

  CategoriesData.categories(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(DataData.data(element));
    });
  }
}

class DataData {
  int id;
  String name;
  String image;
  DataData.data(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
