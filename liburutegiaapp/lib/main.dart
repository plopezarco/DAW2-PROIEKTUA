import 'package:liburutegiaapp/pages/pages.dart';
import 'package:liburutegiaapp/helpers/colors.dart';
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
      /*builder: (context, widget) => ResponsiveWrapper.builder(
        const LoginPage(),
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),*/
      home: const LoginPage(),
    );
  }
}
