import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/model/app_user.dart';
import 'package:todo_project/ui/screens/auth/login_screen.dart';
import 'package:todo_project/ui/screens/home/home_screen.dart';
import 'package:todo_project/ui/utils/app_colors.dart';
import 'package:todo_project/ui/utils/app_theme.dart';
import 'package:todo_project/ui/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routName = "register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";
  String password = "";
  String userName = "";

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
              SizedBox(height: MediaQuery.of(context).size.height * .2),
              TextFormField(
                onChanged: (text) {
                  userName = text;
                },
                decoration: const InputDecoration(
                  label: Text("User Name"),
                ),
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
                height: 66,
              ),
              ElevatedButton(
                  onPressed: () {
                    register();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: Row(
                      children: [
                        Text(
                          "Create account",
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        title: const Text(
          "Register",
          style: AppTheme.appBarTextStyle,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * .12,
        elevation: 0,
      );

  void register() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser newUser = AppUser(
          email: email, id: userCredential.user!.uid, userName: userName);
      await registerInFireStore(newUser);
      AppUser.currentUser = newUser;
      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      hideLoading(context);
      showErrorDialog(
          context, e.message ?? "Something went wrong. Please try again later");
    }
  }

  Future registerInFireStore(AppUser user) async {
    CollectionReference<AppUser> userCollection = AppUser.getCollection();
    await userCollection.doc(user.id).set(user);
    // userCollection.add(user);
  }
}
