import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/screens/auth/login_screen.dart';
import 'package:todo_project/ui/screens/auth/register_screen.dart';
import 'package:todo_project/ui/screens/home/home_screen.dart';
import 'package:todo_project/ui/screens/splash/splash_screen.dart';
import 'package:todo_project/ui/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (_) {
        return ListProvider();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListProvider provider = Provider.of(context);
    return MaterialApp(
      themeMode: provider.currentTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routName: (_) => const RegisterScreen()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}