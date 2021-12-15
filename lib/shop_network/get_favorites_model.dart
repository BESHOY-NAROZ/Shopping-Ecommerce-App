class GetFavoritesModel {
  bool status;
  String message;
  GetFavoritesData data;
  GetFavoritesModel.model(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = GetFavoritesData.data(json['data']);
  }
}

class GetFavoritesData {
  List<GetFavoritesDataData> data = [];
  GetFavoritesData.data(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(GetFavoritesDataData.product(element));
    });
  }
}

class GetFavoritesDataData {
  int id;
  GetFavoritesDataDataProduct product;
  GetFavoritesDataData.product(Map<String, dynamic> json) {
    id = json['id'];
    product = GetFavoritesDataDataProduct.product(json['product']);
  }
}

class GetFavoritesDataDataProduct {
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;
  GetFavoritesDataDataProduct.product(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
