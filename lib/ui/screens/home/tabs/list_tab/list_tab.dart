import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/ui/screens/home/tabs/list_tab/todo_widget.dart';
import 'package:todo_project/ui/utils/app_colors.dart';

class ListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              itemCount: 10, itemBuilder: (context, index) => TodoWidget()),
        ),
      ],
    );
  }
}
