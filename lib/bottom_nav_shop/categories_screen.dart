import 'package:a_m_shop_app/bloc/shop_cubit.dart';
import 'package:a_m_shop_app/bloc/shop_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) {
        ShopCubit cubit = ShopCubit.getShopCubit(context);
        return Scaffold(
          body: ListView.builder(
            itemCount: cubit.categoriesModel.data.data.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  Image(
                      width: 90,
                      height: 90,
                      image: NetworkImage(
                          cubit.categoriesModel.data.data[index].image)),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    cubit.categoriesModel.data.data[index].name.toUpperCase(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                      ),
                      onPressed: () {})
                ],
              );
            },
          ),
        );
      },
    );
  }
}
// Widget build(BuildContext context) {
//   return BlocProvider(
//     create: (BuildContext context) => ShopCubit(),
//     child: BlocConsumer<ShopCubit, ShopStates>(
//       listener: (BuildContext context, state) {},
//       builder: (BuildContext context, state) {
//         return MaterialApp(
//           home: isOnBoardingSeen(),
//         );
//       },
//     ),
//   );
// }
