import 'package:a_m_shop_app/bloc/shop_cubit.dart';
import 'package:a_m_shop_app/bloc/shop_states.dart';
import 'package:a_m_shop_app/on_boarding/shared_pref.dart';
import 'package:a_m_shop_app/shop_screens/shop_layout.dart';
import 'package:a_m_shop_app/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      ShopCubit shopCubitState = ShopCubit.getShopCubit(context);
      if (state is ShopCompleteRegisterState) {
        if (shopCubitState.registerModel.status) {
          isToken = shopCubitState.registerModel.data.token;
          String token = shopCubitState.registerModel.data.token;
          SharedPrefShop.putData('token', token);
          print('registerScreen = $token');
          shopCubitState.userHome();
          shopCubitState.userFavorites();

          Fluttertoast.showToast(
              msg: shopCubitState.registerModel.message,
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
              msg: shopCubitState.registerModel.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }, builder: (context, state) {
      ShopCubit cubit = ShopCubit.getShopCubit(context);

      return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: validateKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }

                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'email must not be empty';
                        }

                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          }

                          return null;
                        },
                        isPassword: cubit.isPassword,
                        controller: passwordController,
                        prefix: Icons.lock_outline,
                        label: 'Password',
                        suffix: cubit.suffixIcon,
                        suffixPressed: () {
                          cubit.changePasswordVisibility();
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'phone must not be empty';
                        }

                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 300,
                      child: RaisedButton(
                        elevation: 20,
                        color: Colors.blue,
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          if (validateKey.currentState.validate()) {
                            cubit.userRegister(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                phoneController.text);
                            print('Validate');
                          } else {
                            print('Not Validate');
                          }
                          cubit.userRegister(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              phoneController.text);
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => LoginScreen()),
                          //     (route) => false);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )),
      );
    });
  }
}
