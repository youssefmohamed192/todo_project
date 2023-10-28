import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/screens/home/tabs/list_tab/todo_widget.dart';
import 'package:todo_project/ui/utils/app_colors.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.refreshTodoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    if (provider.todos.isEmpty) {
      provider.refreshTodoList();
    }
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .12,
          child: Stack(children: [
            Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      color: AppColors.primary,
                    )),
                Expanded(
                    flex: 7,
                    child: Container(
                      color: provider.currentTheme == ThemeMode.light
                          ? AppColors.accent
                          : AppColors.accentDark,
                    )),
              ],
            ),
            CalendarTimeline(
              initialDate: provider.selectedDay,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateSelected: (date) {
                provider.selectedDay = date;
                provider.refreshTodoList();
              },
              leftMargin: 20,
              monthColor: provider.currentTheme == ThemeMode.light ? AppColors.white : AppColors.thirdColor,
              dayColor: provider.currentTheme == ThemeMode.light ? AppColors.primary : AppColors.white,
              activeDayColor: provider.currentTheme == ThemeMode.light ? AppColors.primary : AppColors.white,
              activeBackgroundDayColor: provider.currentTheme == ThemeMode.light ? AppColors.white : AppColors.thirdColor,
              dotsColor: AppColors.transparent,
            ),
          ]),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder: (context, index) => TodoWidget(
                    model: provider.todos[index],
                  )),
        ),
      ],
    );
  }
}