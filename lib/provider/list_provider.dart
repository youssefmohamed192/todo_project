import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/todo_dm.dart';

class ListProvider extends ChangeNotifier{
  List<TodoDM> todos = [];

  refreshTodoList() async {
    CollectionReference<TodoDM> todosCollection =
    FirebaseFirestore.instance.collection(TodoDM.collectionName)
        .withConverter<TodoDM>(
        fromFirestore: (docSnapshot, _){
          Map json = docSnapshot.data() as Map;
          TodoDM todo = TodoDM.fromJson(json);
          return todo;
        },
        toFirestore: (todoDm, _){
          return todoDm.toJson();
        });
    QuerySnapshot<TodoDM> todoSnapshot = await todosCollection.get();
    List<QueryDocumentSnapshot<TodoDM>> docs = todoSnapshot.docs;
    // for(int i = 0; i < docs.length ; i++){
    //   todos.add(docs[i].data());
    // }
    /// better solution
    todos = docs.map((docSnapshot){
      return docSnapshot.data();
    }).toList();
    notifyListeners();
  }
}