import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/utils/app_colors.dart';
import 'package:todo_project/ui/utils/app_theme.dart';

class ModeBottomSheet extends StatefulWidget {


  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    ListProvider provider = Provider.of(context);
    return Column(
      children: [
        SizedBox(height: 12,),
        Text("Select The Mode",
            style: AppTheme.bottomSheetTittleTextStyle),
        ListTile(
          title: getLanguage(provider.currentTheme == ThemeMode.light, "light"),
          onTap: () {
              provider.changeModeTheme(ThemeMode.light);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: getLanguage(provider.currentTheme == ThemeMode.dark, "Dark"),
          onTap: () {
              provider.changeModeTheme(ThemeMode.dark);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  getLanguage(bool isSelected, String language) {
    if (isSelected) {
      return Text(
        language,
        style: AppTheme.taskDescriptionTextStyle
            .copyWith(color: AppColors.primary),
      );
    } else {
      return Text(
        language,
        style: AppTheme.taskDescriptionTextStyle
            .copyWith(fontWeight: FontWeight.normal),
      );
    }
  }
}
