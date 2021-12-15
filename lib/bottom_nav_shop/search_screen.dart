import 'package:a_m_shop_app/bloc/shop_cubit.dart';
import 'package:a_m_shop_app/bloc/shop_states.dart';
import 'package:a_m_shop_app/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

TextEditingController searchController = TextEditingController();

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          ShopCubit cubit = ShopCubit.getShopCubit(context);
          return Scaffold(
              appBar: AppBar(
                title: Text('SearchScreen'),
              ),
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultFormField(
                        controller: searchController,
                        label: 'type here',
                        prefix: Icons.search,
                        onChange: (value) {
                          cubit.userSearch(searchKey: value);
                        }),
                  ),
                  cubit.searchModel.data != null
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: cubit.searchModel.data.data.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: <Widget>[
                                  Image(
                                      width: 90,
                                      height: 90,
                                      image: NetworkImage(cubit
                                          .searchModel.data.data[index].image)),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 300,
                                    child: Text(
                                      cubit.searchModel.data.data[index].name
                                          .toUpperCase()
                                          .toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : Center(child: LinearProgressIndicator()),
                ],
              ));
        });
  }
}
