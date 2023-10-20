import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/model/app_user.dart';
import 'package:todo_project/ui/screens/auth/register_screen.dart';
import 'package:todo_project/ui/screens/home/home_screen.dart';
import 'package:todo_project/ui/utils/app_colors.dart';
import 'package:todo_project/ui/utils/app_theme.dart';
import 'package:todo_project/ui/utils/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .26),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Welcome Back",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: const InputDecoration(
                  label: Text("E-mail"),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: Row(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RegisterScreen.routName);
                },
                child: const Text("Create an account",
                    style: TextStyle(color: AppColors.black, fontSize: 18)),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        title: const Text(
          "Login",
          style: AppTheme.appBarTextStyle,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * .12,
        elevation: 0,
      );

  void login() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser currentUser =
          await getUserFormFireStore(userCredential.user!.uid);
      AppUser.currentUser = currentUser;
      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      hideLoading(context);
      showErrorDialog(
          context, e.message ?? "Something went wrong. Please try again later");
    }
  }

  Future<AppUser> getUserFormFireStore(String id) async {
    CollectionReference<AppUser> userCollection = AppUser.getCollection();
    DocumentSnapshot<AppUser> documentSnapshot =
        await userCollection.doc(id).get();
    return documentSnapshot.data()!;
  }
}
