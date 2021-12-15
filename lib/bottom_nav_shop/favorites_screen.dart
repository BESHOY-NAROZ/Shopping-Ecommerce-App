import 'package:a_m_shop_app/bloc/shop_cubit.dart';
import 'package:a_m_shop_app/bloc/shop_states.dart';
import 'package:a_m_shop_app/shop_network/get_favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, ShopStates state) {},
        builder: (BuildContext context, ShopStates state) {
          ShopCubit cubit = ShopCubit.getShopCubit(context);
          List<GetFavoritesDataData> list = cubit.getFavoritesModel.data.data;
          return Scaffold(
            body: state is ShopChangeFavoritesState
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 20.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: Key(list[index].product.id.toString()),
                        onDismissed: (direction) async {
                          await cubit
                              .userChangeFavorites(list[index].product.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 150,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Image(
                                      fit: BoxFit.fill,
                                      height: 150,
                                      width: 150,
                                      image: NetworkImage(
                                          list[index].product.image),
                                    ),
                                    if (list[index].product.discount != 0)
                                      Container(
                                        color: Colors.red,
                                        child: Text(
                                          'DISCOUNT',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  width: 200,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        list[index].product.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18, height: 1.3),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              list[index]
                                                  .product
                                                  .price
                                                  .toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blueAccent),
                                            ),
                                          ),
                                          if (list[index].product.discount != 0)
                                            Text(
                                              list[index]
                                                  .product
                                                  .old_price
                                                  .toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          Spacer(),
                                          IconButton(
                                            icon: Icon(
                                              // cubit.favMap[cubit.homeModel.data.products[index].id]
                                              //     ? Icons.favorite
                                              //     :
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          );
        });
  }
}
