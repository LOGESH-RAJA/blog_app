import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

void showSnakbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
        backgroundColor: AppPallete.transparentColor, content: Text(content,style:const  TextStyle(color: AppPallete.whiteColor),)));
}
