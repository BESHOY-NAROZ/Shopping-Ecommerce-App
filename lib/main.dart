import 'package:a_m_shop_app/bloc/shop_cubit.dart';
import 'package:a_m_shop_app/bloc/shop_states.dart';
import 'package:a_m_shop_app/on_boarding/onboarding_screen.dart';
import 'package:a_m_shop_app/on_boarding/shared_pref.dart';
import 'package:a_m_shop_app/shop_network/shop_dio.dart';
import 'package:a_m_shop_app/shop_screens/login_screen.dart';
import 'package:a_m_shop_app/shop_screens/shop_layout.dart';
import 'package:a_m_shop_app/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ShopDio.defineDio();
  await SharedPrefShop.sharedDefinition();
  isToken = SharedPrefShop.getData('token');
  print('isOnBoardingSeen = $isToken');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopCubit()
          ..userLogin()
          ..userHome()
          ..userCategories()
          ..userFavorites()
          ..userProfile()
          ..userSearch(),
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            return MaterialApp(
              home: isOnBoardingSeen(),
            );
          },
        ));
  }

  Widget isOnBoardingSeen() {
    bool isSeen = SharedPrefShop.getData('onBoarding3');

    if (isSeen != null) {
      if (isToken != null) {
        return ShopLayout();
      } else {
        return LoginScreen();
      }
    } else
      return OnBoardingScreen();
  }
}
// Widget widget;
// if (isSeen != null) {
// if (isToken != null) {
// widget = ShopLayout();
// } else {
// widget = LoginScreen();
// }
// } else
// widget = OnBoardingScreen();
