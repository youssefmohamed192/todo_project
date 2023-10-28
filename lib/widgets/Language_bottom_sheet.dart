import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/utils/app_colors.dart';
import 'package:todo_project/ui/utils/app_theme.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {

  @override
  Widget build(BuildContext context) {
    ListProvider provider = Provider.of(context);
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Text("Select Your Language",
            style: AppTheme.bottomSheetTittleTextStyle),
        ListTile(
          title: getLanguage(provider.currentLocale == "en", "English"),
          onTap: () {
            setState(() {
              provider.changeCurrentLocale("en");
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: getLanguage(provider.currentLocale == "ar", "Arabic"),
          onTap: () {
            setState(() {

              provider.changeCurrentLocale("ar");
            });
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
