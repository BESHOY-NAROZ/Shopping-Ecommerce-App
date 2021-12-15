import 'package:a_m_shop_app/bloc/shop_cubit.dart';
import 'package:a_m_shop_app/bloc/shop_states.dart';
import 'package:a_m_shop_app/on_boarding/shared_pref.dart';
import 'package:a_m_shop_app/shop_screens/login_screen.dart';
import 'package:a_m_shop_app/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.getShopCubit(context);

          nameController.text = cubit.profileModel.data.name;
          emailController.text = cubit.profileModel.data.email;
          phoneController.text = cubit.profileModel.data.phone;

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
                padding: const EdgeInsets.all(20.0),
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
                          'LOGOUT',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          SharedPrefShop.removeData('token');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false);
                          isToken = null;
                          print('After Remove = $isToken');
                        },
                      ),
                    )
                  ],
                )),
          );
        });
  }
}
