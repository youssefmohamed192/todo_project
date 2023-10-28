import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/screens/home/home_screen.dart';
import 'package:todo_project/ui/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen())); // Replace splash with your Home screen
    });
  }

  @override
  Widget build(BuildContext context) {
    ListProvider provider = Provider.of(context);
    return Scaffold(
      body: provider.currentTheme == ThemeMode.light
          ? Image.asset(AppAssets.splash)
          : Image.asset(AppAssets.darkSplash),
    );
  }
}
