import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/utils/app_colors.dart';
import 'package:todo_project/ui/utils/app_theme.dart';
import 'package:todo_project/widgets/Language_bottom_sheet.dart';
import 'package:todo_project/widgets/mode_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {

  @override
  Widget build(BuildContext context) {
    ListProvider provider = Provider.of(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.045,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.09,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(flex: 1,),
             Text("Language",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color:provider.currentTheme == ThemeMode.light
                        ? AppColors.black : AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 18,),
            InkWell(
                onTap: (){
                  onLanguageClick();
                },
                child: buildMyRow(provider.currentLocale == "en" ? "English" : "Arabic")),
            const SizedBox(height: 18,),
             Text("Mode",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: provider.currentTheme == ThemeMode.light
                        ? AppColors.black : AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 18,),
            InkWell(
                onTap: (){
                  onThemeClick();
                },
                child: buildMyRow(provider.currentTheme == ThemeMode.light ? "Light" : "Dark")),
            Spacer(flex: 9,),
          ],
        ),
      ),
    );
  }


  Widget buildMyRow(String option) {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(width: 1.5, color: AppColors.primary)),
      child: Row(
        children: [
          Text(option,style: TextStyle(color: AppColors.primary)),
          const Spacer(),
          const Icon(Icons.arrow_drop_down,color: AppColors.primary),
        ],
      ),
    );
  }

  void onLanguageClick() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LanguageBottomSheet();
      },
    );
  }

  void onThemeClick() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ModeBottomSheet();
      },
    );
  }
}
