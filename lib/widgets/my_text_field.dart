import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/utils/app_colors.dart';

class MyTextField extends StatelessWidget {
  String? hintText;
  TextEditingController controller;

  MyTextField({this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    ListProvider provider = Provider.of(context);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: provider.currentTheme == ThemeMode.light
              ? AppColors.grey
              : AppColors.white,
        ),
      ),
    );
  }
}
