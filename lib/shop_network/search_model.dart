class SearchModel {
  bool status;
  SearchData data;
  SearchModel.data(Map<String, dynamic> json) {
    status = json['current_page'];
    data = SearchData.data(json['data']);
  }
}

class SearchData {
  int current_page;
  List<SearchDataData> data = [];
  SearchData.data(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(SearchDataData.data(element));
    });
  }
}

class SearchDataData {
  int id;
  var price;
  String image;
  String name;
  String description;
  bool in_favorites;
  bool in_cart;
  SearchDataData.data(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
