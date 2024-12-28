import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onpressed;
  GradientButton(
      {super.key, required this.buttonName, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient:const  LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
              colors: [AppPallete.gradient1, AppPallete.gradient2])),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            fixedSize: const Size(340, 50)),
        child: Text(
          buttonName,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
