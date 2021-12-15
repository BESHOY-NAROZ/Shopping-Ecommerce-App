import 'package:a_m_shop_app/bloc/shop_cubit.dart';
import 'package:a_m_shop_app/bloc/shop_states.dart';
import 'package:a_m_shop_app/bottom_nav_shop/search_screen.dart';
import 'package:a_m_shop_app/bottom_nav_shop/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          ShopCubit shopCubit = ShopCubit.getShopCubit(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Salla',
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()));
                  },
                ),
              ],
            ),
            body: shopCubit.bottomScreens[shopCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                shopCubit.changeBottomNav(index);
              },
              currentIndex: shopCubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  title: Text('Categories'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  title: Text('Favorites'),
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     Icons.settings,
                //   ),
                //   title: Text('Settings'),
                // ),
              ],
            ),
          );
        });
  }
}
