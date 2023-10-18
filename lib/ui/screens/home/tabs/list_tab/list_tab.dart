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
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.refreshTodoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    if(provider.todos.isEmpty) {
      provider.refreshTodoList();
    }
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .12,
          child: Stack(children: [
            Column(
              children: [
                Expanded(flex: 3,child: Container(color: AppColors.primary,)),
                Expanded(flex: 7,child: Container(color: AppColors.accent,)),
              ],
            ),
            CalendarTimeline(
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              monthColor: AppColors.white,
              dayColor: AppColors.primary,
              activeDayColor: AppColors.primary,
              activeBackgroundDayColor: AppColors.white,
              dotsColor: AppColors.transparent,
            ),
          ]),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: provider.todos.length, itemBuilder: (context, index) =>
              TodoWidget(model: provider.todos[index],)),
        ),
      ],
    );
  }


}
