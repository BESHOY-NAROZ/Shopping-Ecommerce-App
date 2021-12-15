import 'package:a_m_shop_app/bloc/shop_states.dart';
import 'package:a_m_shop_app/bottom_nav_shop/categories_screen.dart';
import 'package:a_m_shop_app/bottom_nav_shop/favorites_screen.dart';
import 'package:a_m_shop_app/bottom_nav_shop/home_screen.dart';
import 'package:a_m_shop_app/shop_network/cange_favorites_model.dart';
import 'package:a_m_shop_app/shop_network/categories_model.dart';
import 'package:a_m_shop_app/shop_network/get_favorites_model.dart';
import 'package:a_m_shop_app/shop_network/home_model.dart';
import 'package:a_m_shop_app/shop_network/login_model.dart';
import 'package:a_m_shop_app/shop_network/profile_model.dart';
import 'package:a_m_shop_app/shop_network/register_model.dart';
import 'package:a_m_shop_app/shop_network/search_model.dart';
import 'package:a_m_shop_app/shop_network/shop_dio.dart';
import 'package:a_m_shop_app/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit getShopCubit(context) => BlocProvider.of(context);

  UserLoginModel userLoginData;
  userLogin({String email, String password}) {
    emit(ShopLoadingLoginState());
    ShopDio.postData(
      url: 'login',
      data: {'email': email, 'password': password},
    ).then((value) {
      userLoginData = UserLoginModel.jsonData(value.data);
      emit(ShopCompleteLoginState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorLoginState());
    });
  }

  ProfileModel profileModel;
  userProfile() {
    print('userProfile = $isToken');
    ShopDio.getData(url: 'profile', token: isToken).then((value) {
      profileModel = ProfileModel.jsonData(value.data);
      print(profileModel.data.name);
      emit(ShopCompleteProfileState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorProfileState());
    });
  }

  Map favMap;
  HomeModel homeModel;
  userHome() {
    print('homeModel = $isToken');
    emit(ShopLoadingHomeState());
    ShopDio.getData(url: 'home', token: isToken).then((value) {
      homeModel = HomeModel.home(value.data);
      //  ShopDio.printWrapped(value.toString());
      favMap = homeModel.data.favMap;

      emit(ShopCompleteHomeState());
    }).catchError((error) {
      emit(ShopErrorHomeState());
    });
  }

  CategoriesModel categoriesModel;
  userCategories() {
    ShopDio.getData(url: 'categories').then((value) {
      categoriesModel = CategoriesModel.categories(value.data);
      emit(ShopCompleteCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel favoritesModel;
  userChangeFavorites(int id) async {
    homeModel.data.favMap[id] = !homeModel.data.favMap[id];
    emit(ShopChangeFavoritesState());
    print('userChangeFavorites = $isToken');

    await ShopDio.postData(
            url: 'favorites', data: {'product_id': id}, token: isToken)
        .then((value) {
      favoritesModel = ChangeFavoritesModel.change(value.data);
      userFavorites();
      if (!favoritesModel.status) {
        homeModel.data.favMap[id] = !homeModel.data.favMap[id];
        emit(ShopCompleteChangeFavoritesState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorChangeFavoritesState());
    });
  }

  GetFavoritesModel getFavoritesModel;
  userFavorites() {
    print('userFavorites = $isToken');
    ShopDio.getData(url: 'favorites', token: isToken).then((value) {
      getFavoritesModel = GetFavoritesModel.model(value.data);
      emit(ShopCompleteFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoritesState());
    });
  }

  RegisterModel registerModel;
  userRegister(
    String name,
    String email,
    String password,
    String phone,
  ) {
    emit(ShopLoadingRegisterState());
    ShopDio.postData(url: 'register', data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      emit(ShopCompleteRegisterState());
      registerModel = RegisterModel.data(value.data);
      print(registerModel.data.token);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorRegisterState());
    });
  }

  SearchModel searchModel;
  userSearch({String searchKey}) {
    emit(ShopLoadingSearchState());
    ShopDio.postData(
      token: isToken,
      url: 'products/search',
      data: {'text': searchKey},
    ).then((value) {
      searchModel = SearchModel.data(value.data);

      emit(ShopCompleteSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorSearchState());
    });
  }

  IconData suffixIcon = Icons.visibility;
  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopPasswordVisibilityState());
  }

  //////////////////////   Bottom Navigation        ////////////////////

  List<Widget> bottomScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
  ];
  int currentIndex = 0;

  changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
}
