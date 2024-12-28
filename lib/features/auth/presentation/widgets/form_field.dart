import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  const AuthField(
      {super.key, required this.hintText, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: textEditingController,
      validator: (value) {
        if (value == null) {
          return '$hintText should not be empty';
        }
        return null;
      },
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
