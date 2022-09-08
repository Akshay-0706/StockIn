import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StockIn',
      theme: NewTheme.lightTheme(),
      // darkTheme: NewTheme.darkTheme(),
      routes: routes,
    );
  }
}
