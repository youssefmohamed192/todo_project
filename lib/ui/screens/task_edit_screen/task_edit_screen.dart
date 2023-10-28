import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/model/todo_dm.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/screens/home/home_screen.dart';
import 'package:todo_project/ui/utils/app_colors.dart';
import 'package:todo_project/ui/utils/app_theme.dart';

class TaskEditScreen extends StatefulWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TodoDM model;

  TaskEditScreen({super.key, required this.model}) {
    // make controller have initial value cause if user wanted only to change the date.
    titleController.text = model.title;
    descriptionController.text = model.description;
  }

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    provider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("To Do List"),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    color: AppColors.primary,
                  )),
              Expanded(
                  flex: 8,
                  child: Container(
                    color: provider.currentTheme == ThemeMode.light
                        ? AppColors.accent
                        : AppColors.accentDark,
                  ))
            ],
          ),
          Center(
            child: Container(
              height: size.height * 0.7,
              width: size.width * 0.85,
              decoration: BoxDecoration(
                  color: provider.currentTheme == ThemeMode.light
                      ? AppColors.white
                      : AppColors.thirdColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Edit Task",
                          textAlign: TextAlign.center,
                          style: AppTheme.appBarTextStyle.copyWith(
                              fontSize: 18,
                              color: provider.currentTheme == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.white)),
                      const SizedBox(
                        height: 46,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: provider.currentTheme == ThemeMode.light
                              ? AppColors.black
                              : AppColors.white,
                        ),
                        controller: widget.titleController,
                        onChanged: (newTitle) {
                          widget.model.title = newTitle;
                        },
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: provider.currentTheme == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                            hintText: "This is title"),
                      ),
                      const SizedBox(height: 26),
                      TextFormField(
                        style: TextStyle(
                          color: provider.currentTheme == ThemeMode.light
                              ? AppColors.black
                              : AppColors.white,
                        ),
                        controller: widget.descriptionController,
                        onChanged: (newDescription) {
                          widget.model.description = newDescription;
                        },
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: provider.currentTheme == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                            hintText: "Task details"),
                      ),
                      const SizedBox(height: 22),
                      Text("Select Date",
                          style: TextStyle(
                              color: provider.currentTheme == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.white)),
                      const SizedBox(
                        height: 24,
                      ),
                      InkWell(
                        onTap: () {
                          showMyDatePicker();
                        },
                        child: Text(
                            "${widget.model.date.day}/${widget.model.date.month}/${widget.model.date.year}",
                            textAlign: TextAlign.center,
                            style: AppTheme.bottomSheetTittleTextStyle.copyWith(
                                fontWeight: FontWeight.normal,
                                color: AppColors.grey)),
                      ),
                      const SizedBox(
                        height: 112,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () async {
                              await provider.todoSaveChanges(widget.model);
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Save Changes", style: TextStyle()),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    widget.model.date = await showDatePicker(
            context: context,
            initialDate: widget.model.date,
            firstDate: widget.model.date,
            lastDate: widget.model.date.add(const Duration(days: 365))) ??
        widget.model.date;
    setState(() {});
  }
}
