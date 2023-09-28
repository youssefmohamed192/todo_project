import 'package:flutter/material.dart';
import 'package:todo_project/ui/utils/app_colors.dart';
import 'package:todo_project/ui/utils/app_theme.dart';
import 'package:todo_project/widgets/my_text_field.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Add New task",
              textAlign: TextAlign.center,
              style: AppTheme.bottomSheetTittleTextStyle),
          const SizedBox(height: 16),
          MyTextField(hintText: "Enter task title"),
          const SizedBox(height: 8),
          MyTextField(hintText: "Enter task description"),
          const SizedBox(height: 16),
          Text("Select Date",
              style: AppTheme.bottomSheetTittleTextStyle
                  .copyWith(fontWeight: FontWeight.normal,color: AppColors.lightBlack)),
          Text("28/9/2023",
              textAlign: TextAlign.center,
              style: AppTheme.bottomSheetTittleTextStyle.copyWith(
                  fontWeight: FontWeight.normal, color: AppColors.grey)),
          const Spacer(),
          ElevatedButton(onPressed: () {}, child: const Text("Add"))
        ],
      ),
    );
  }
}
