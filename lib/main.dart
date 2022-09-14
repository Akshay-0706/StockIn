import 'package:flutter/material.dart';
import 'package:stockin/global.dart';

import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    themeChanger.addListener(() {
      setState(() {});
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StockIn',
      theme: NewTheme.lightTheme(),
      darkTheme: NewTheme.darkTheme(),
      themeMode: themeChanger.currentTheme(),
      routes: routes,
    );
  }
}
