import 'package:liburutegiaapp/pages/intro_page.dart';
import 'package:liburutegiaapp/pages/login_page.dart';
import 'package:liburutegiaapp/theme/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Liburutegia',
      theme: ThemeData(brightness: Brightness.light, primaryColor: themeMain),
      home: const LoginPage(),
    );
  }
}
