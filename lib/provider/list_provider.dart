import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/model/app_user.dart';
import 'package:todo_project/model/todo_dm.dart';

class ListProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLocale = "en";

  List<TodoDM> todos = [];
  DateTime selectedDay = DateTime.now();

  refreshTodoList() async {
    CollectionReference<TodoDM> todosCollection = AppUser.getCollection()
        .doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName)
        .withConverter<TodoDM>(fromFirestore: (docSnapshot, _) {
      Map json = docSnapshot.data() as Map;
      TodoDM todo = TodoDM.fromJson(json);
      return todo;
    }, toFirestore: (todoDm, _) {
      return todoDm.toJson();
    });
    QuerySnapshot<TodoDM> todoSnapshot = await todosCollection
        .orderBy("date")
        // .where("date", isEqualTo: selectedDay)
        .get();
    List<QueryDocumentSnapshot<TodoDM>> docs = todoSnapshot.docs;
    // for(int i = 0; i < docs.length ; i++){
    //   todos.add(docs[i].data());
    // }
    /// better solution
    todos = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();

    // for (int i = 0; i < todos.length; i++) {
    //   if (todos[i].date.day != selectedDay.day ||
    //       todos[i].date.month != selectedDay.month ||
    //       todos[i].date.year != selectedDay.year){
    //     todos.removeAt(i);
    //     i--;
    //   }
    // }
    // better solution.
    todos = todos.where((todo) {
      if (todo.date.day != selectedDay.day ||
          todo.date.month != selectedDay.month ||
          todo.date.year != selectedDay.year) {
        return false;
      } else {
        return true;
      }
    }).toList();
    notifyListeners();
  }

  Future<void> todoIsDone(TodoDM todoDM) async {
    await AppUser.getCollection()
        .doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName)
        .doc(todoDM.id)
        .set(todoDM.toJson());
    refreshTodoList();
  }

  Future<void> todoDelete(String taskID) async {
    await AppUser.getCollection()
        .doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName)
        .doc(taskID)
        .delete();
    refreshTodoList();
  }

  Future<void> todoSaveChanges(TodoDM todoDM) async {
    await AppUser.getCollection()
        .doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName)
        .doc(todoDM.id)
        .set(todoDM.toJson());
    refreshTodoList();
  }

  changeModeTheme(ThemeMode newModeTheme) {
    currentTheme = newModeTheme;
    notifyListeners();
  }

  changeCurrentLocale(String newLocale) {
    currentLocale = newLocale;
    notifyListeners();
  }
}
