import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDM {
  static const String collectionName = "todos";
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;

  TodoDM(this.id, this.title, this.description, this.date, this.isDone);

  TodoDM.fromJson(Map Json){
    id = Json["id"];
    title = Json["title"];
    description = Json["description"];
    Timestamp time = Json["date"];
    date = time.toDate();
    isDone = Json["isDone"];
  }

  Map<String, Object?> toJson() {
    return {
      "id" : id,
      "title" : title,
      "description" : description,
      "date" : date,
      "isDone" :isDone
    };
}
}