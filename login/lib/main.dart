import 'package:flutter/material.dart';
import 'theme.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/welcome.dart';
import 'pages/diary.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Proyecto Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => LoginPage(),
        '/register': (_) => RegisterPage(),
        '/welcome': (_) => WelcomePage(),
        '/diary': (_) => DiaryPage(),
      },
    );
  }
}
