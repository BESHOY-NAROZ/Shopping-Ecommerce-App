class HomeModel {
  bool status;
  HomeData data;

  HomeModel.home(Map<String, dynamic> json) {
    this.status = json['status'];
    this.data =
        json['data'] != null ? data = HomeData.home(json['data']) : null;
  }
}

class HomeData {
  List<BannersData> banners = [];
  List<ProductsData> products = [];
  Map<int, bool> favMap = {};
  // String ad;

  HomeData.home(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersData.banners(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsData.products(element));
    });
    products.forEach((element) {
      favMap.addAll({
        element.id: element.in_favorites,
      });
    });
    //  this.ad = json['ad'];
  }
}

class BannersData {
  int id;
  String image;
  //CategoryBannersData category;
  // String product;

  BannersData.banners(Map<String, dynamic> json) {
    this.id = json['id'];
    this.image = json['image'];
    // this.category = json['category'] != null
    //     ? category = CategoryBannersData.category(json['category'])
    //     : null;
    // this.product = json['product'];
  }
}

// class CategoryBannersData {
//   int id;
//   String image;
//   String name;
//
//   CategoryBannersData.category(Map<String, dynamic> json) {
//     this.id = json['id'];
//     this.image = json['image'];
//     this.name = json['name'];
//   }
// }

class ProductsData {
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;
  bool in_favorites;
  bool in_cart;

  ProductsData.products(Map<String, dynamic> json) {
    this.id = json['id'];
    this.price = json['price'];
    this.old_price = json['old_price'];
    this.discount = json['discount'];
    this.image = json['image'];
    this.name = json['name'];
    this.in_favorites = json['in_favorites'];
    this.in_cart = json['in_cart'];
  }
}
