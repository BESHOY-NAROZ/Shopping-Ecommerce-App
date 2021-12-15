import 'package:a_m_shop_app/bloc/shop_cubit.dart';
import 'package:a_m_shop_app/bloc/shop_states.dart';
import 'package:a_m_shop_app/on_boarding/shared_pref.dart';
import 'package:a_m_shop_app/shop_screens/register_screen.dart';
import 'package:a_m_shop_app/shop_screens/shop_layout.dart';
import 'package:a_m_shop_app/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var validateKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        ShopCubit shopCubitState = ShopCubit.getShopCubit(context);
        if (state is ShopCompleteLoginState) {
          if (shopCubitState.userLoginData.status) {
            isToken = shopCubitState.userLoginData.data.token;
            String token = shopCubitState.userLoginData.data.token;
            SharedPrefShop.putData('token', token);
            print('LoginScreen = $token');
            shopCubitState.userHome();
            shopCubitState.userFavorites();

            Fluttertoast.showToast(
                msg: shopCubitState.userLoginData.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ShopLayout()),
                (route) => false);
          } else {
            Fluttertoast.showToast(
                msg: shopCubitState.userLoginData.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.getShopCubit(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.all(12),
              color: Colors.white,
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Form(
                  key: validateKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'login now to browse our offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      defaultFormField(
                        validate: (String value) {
                          if (value.isEmpty) {
                            return ('email must not be empty');
                          }
                          return null;
                        },
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        prefix: Icons.mail_outline,
                        label: 'Email Address',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          validate: (String value) {
                            if (value.isEmpty) {
                              return ('password must not be empty');
                            }
                            return null;
                          },
                          isPassword: shopCubit.isPassword,
                          controller: passwordController,
                          prefix: Icons.lock_outline,
                          label: 'Password',
                          suffix: shopCubit.suffixIcon,
                          suffixPressed: () {
                            shopCubit.changePasswordVisibility();
                          }),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 300,
                        child: RaisedButton(
                          elevation: 20,
                          color: Colors.blue,
                          onPressed: () {
                            if (validateKey.currentState.validate()) {
                              shopCubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                              print('Validate');
                            } else {
                              print('Not Validate');
                            }
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Don\'t have an account'),
                          FlatButton(
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
