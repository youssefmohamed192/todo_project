import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  late String email;
  late String id;
  late String userName;
  static AppUser? currentUser;
  static const collectionName = "users";

  AppUser({required this.email, required this.id, required this.userName});

  AppUser.fromJson(Map json) {
    id = json["id"];
    email = json["email"];
    userName = json["username"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "username": userName,
    };
  }

  static CollectionReference<AppUser> getCollection() {
    return FirebaseFirestore.instance
        .collection(AppUser.collectionName)
        .withConverter(fromFirestore: (snapshot, _) {
      return AppUser.fromJson(snapshot.data()!);
    }, toFirestore: (user, _) {
      return user.toJson();
    });
  }
}
