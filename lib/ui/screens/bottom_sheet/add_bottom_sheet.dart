import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/model/todo_dm.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/utils/app_colors.dart';
import 'package:todo_project/ui/utils/app_theme.dart';
import 'package:todo_project/widgets/my_text_field.dart';

class AddBottomSheet extends StatefulWidget {

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDay = DateTime.now();
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
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
          MyTextField(hintText: "Enter task title", controller: titleController),
          const SizedBox(height: 8),
          MyTextField(hintText: "Enter task description",controller: descriptionController),
          const SizedBox(height: 16),
          Text("Select Date",
              style: AppTheme.bottomSheetTittleTextStyle
                  .copyWith(fontWeight: FontWeight.normal,color: AppColors.lightBlack)),
          // instead of inkwell you can use GestureDetector().
          InkWell(
            onTap: (){
              showMyDatePicker();
            },
            child: Text("${selectedDay.day}/${selectedDay.month}/${selectedDay.year}",
                textAlign: TextAlign.center,
                style: AppTheme.bottomSheetTittleTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: AppColors.grey)),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                addTodoToFireStore();
              },
              child: const Text("Add"))
        ],
      ),
    );
  }

  void addTodoToFireStore() {
    CollectionReference todosCollectionRef = FirebaseFirestore.instance.collection(TodoDM.collectionName);
    DocumentReference newEmptyDoc = todosCollectionRef.doc();
    newEmptyDoc.set({
          "id" : newEmptyDoc.id,
          "title" : titleController.text,
          "description" : descriptionController.text,
          "date" : selectedDay,
          "isDone" : false
        }).timeout(Duration(milliseconds: 300),onTimeout: () {
          provider.refreshTodoList();
          Navigator.pop(context);
        },);
  }

  void showMyDatePicker() async{
    selectedDay = await showDatePicker(
        context: context,
        initialDate: selectedDay,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))) ?? selectedDay;
    setState(() {});
  }
}
