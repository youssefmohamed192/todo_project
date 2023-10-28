import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/model/todo_dm.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/screens/task_edit_screen/task_edit_screen.dart';
import 'package:todo_project/ui/utils/app_assets.dart';
import 'package:todo_project/ui/utils/app_colors.dart';
import 'package:todo_project/ui/utils/app_theme.dart';

class TodoWidget extends StatelessWidget {
  final TodoDM model;
  late ListProvider provider;

  TodoWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
      decoration: BoxDecoration(
          color: provider.currentTheme == ThemeMode.light
              ? AppColors.white
              : AppColors.thirdColor,
          borderRadius: BorderRadius.circular(10)),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: .45,
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskEditScreen(model: model),
                    ));
              },
              backgroundColor: AppColors.editColor,
              foregroundColor: AppColors.white,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            SlidableAction(
              onPressed: (context) {
                provider.todoDelete(model.id);
              },
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          height: MediaQuery.of(context).size.height * .13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: provider.currentTheme == ThemeMode.light
                ? AppColors.white
                : AppColors.thirdColor,
          ),
          child: Row(
            children: [
              VerticalDivider(
                  thickness: 3,
                  color: model.isDone ? AppColors.green : AppColors.primary),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(model.title,
                        style: model.isDone
                            ? AppTheme.taskTittleTextStyle
                                .copyWith(color: AppColors.green)
                            : AppTheme.taskTittleTextStyle),
                    Text(
                      model.description,
                      style: model.isDone
                          ? AppTheme.taskDescriptionTextStyle
                              .copyWith(color: AppColors.green)
                          : AppTheme.taskDescriptionTextStyle,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  model.isDone = !model.isDone;
                  provider.todoIsDone(model);
                },
                child: model.isDone
                    ? const Text(
                        "Done!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.green),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        child: const ImageIcon(
                          AssetImage(AppAssets.checkIcon),
                          color: AppColors.white,
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
