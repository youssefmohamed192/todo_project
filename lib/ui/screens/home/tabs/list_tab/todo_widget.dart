import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_project/model/todo_dm.dart';
import 'package:todo_project/ui/utils/app_assets.dart';
import 'package:todo_project/ui/utils/app_colors.dart';
import 'package:todo_project/ui/utils/app_theme.dart';

class TodoWidget extends StatelessWidget {
  final TodoDM model;

  const TodoWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: .25,
          children: [
            SlidableAction(
              onPressed: (context) {},
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
            color: AppColors.white,
          ),
          child: Row(
            children: [
              const VerticalDivider(),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(model.title, style: AppTheme.taskTittleTextStyle),
                    Text(
                      model.description,
                      style: AppTheme.taskDescriptionTextStyle,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: const ImageIcon(
                    AssetImage(AppAssets.checkIcon),
                    color: AppColors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
