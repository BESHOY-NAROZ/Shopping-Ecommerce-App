import 'package:a_m_shop_app/bloc/shop_cubit.dart';
import 'package:a_m_shop_app/bloc/shop_states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {
        ShopCubit cubit = ShopCubit.getShopCubit(context);
        if (state is ShopCompleteChangeFavoritesState) {
          if (!cubit.favoritesModel.status) {
            Fluttertoast.showToast(
                msg: cubit.favoritesModel.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (BuildContext context, state) {
        ShopCubit cubit = ShopCubit.getShopCubit(context);
        return Scaffold(
            body: cubit.homeModel != null
                ? SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CarouselSlider(
                            options: CarouselOptions(
                                viewportFraction: 1,
                                height: 250,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                autoPlay: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                scrollDirection: Axis.horizontal,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(seconds: 1)),
                            items: List.generate(
                                cubit.homeModel.data.banners.length,
                                (index) => Image(
                                      image: NetworkImage(
                                          '${cubit.homeModel.data.banners[index].image}'),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )).toList()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.categoriesModel.data.data.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 150,
                                  height: 150,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      Image(
                                          fit: BoxFit.contain,
                                          height: 150,
                                          width: 150,
                                          image: NetworkImage(cubit
                                              .categoriesModel
                                              .data
                                              .data[index]
                                              .image)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: Container(
                                          width: 100,
                                          height: 15,
                                          color:
                                              Colors.blueAccent.withOpacity(.7),
                                          child: Text(
                                            cubit.categoriesModel.data
                                                .data[index].name,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: GridView.count(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              childAspectRatio: 1 / 1.483,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              crossAxisCount: 2,
                              children: List.generate(
                                  cubit.homeModel.data.products.length,
                                  (index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Stack(
                                        children: <Widget>[
                                          Image(
                                              fit: BoxFit.fill,
                                              height: 200,
                                              width: double.infinity,
                                              image: NetworkImage(cubit
                                                  .homeModel
                                                  .data
                                                  .products[index]
                                                  .image)),
                                          if (cubit.homeModel.data
                                                  .products[index].discount !=
                                              0)
                                            Container(
                                              color: Colors.red,
                                              child: Text(
                                                'DISCOUNT',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        cubit.homeModel.data.products[index]
                                            .name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15, height: 1.3),
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            cubit.homeModel.data.products[index]
                                                .price
                                                .toString(),
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        if (cubit.homeModel.data.products[index]
                                                .discount !=
                                            0)
                                          Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: Text(
                                              cubit.homeModel.data
                                                  .products[index].old_price
                                                  .toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        Spacer(),
                                        IconButton(
                                            icon: Icon(
                                              cubit.favMap[cubit.homeModel.data
                                                      .products[index].id]
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              cubit.userChangeFavorites(cubit
                                                  .homeModel
                                                  .data
                                                  .products[index]
                                                  .id);
                                            })
                                      ],
                                    ),
                                  ],
                                );
                              })),
                        )
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator()));
      },
    );
  }
}

// onPressed: () {
// SharedPrefShop.removeData('token');
// Navigator.pushAndRemoveUntil(
// context,
// MaterialPageRoute(builder: (context) => LoginScreen()),
// (route) => false);
