import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String? hintText;

  MyTextField({this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
