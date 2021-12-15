import 'package:flutter/material.dart';

String isToken;

class DefaultTextForm extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  Icon icon;
  Function onTap;
  Function onChanged;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  Widget suffix;
  Widget suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffix: suffix,
        suffixIcon:
            suffix != null ? IconButton(icon: null, onPressed: null) : null,
        icon: icon,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  DefaultTextForm(
      {this.controller,
      this.hintText,
      this.keyboardType,
      this.icon,
      this.onTap,
      this.onChanged,
      this.validator});
}

Widget defaultFormField({
  TextEditingController controller,
  TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  Function validate,
  String label,
  IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
