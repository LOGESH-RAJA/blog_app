import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  const AuthField({super.key, required this.hintText, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: (value) {
        if (value == null) {
          return '$hintText should not be empty';
        }
      },
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
