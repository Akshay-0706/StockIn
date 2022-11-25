import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stockin/global.dart';

import 'firebase_options.dart';
import 'routes.dart';
import 'theme.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   // themeChanger.addListener(() {
  //   //   setState(() {});
  //   // });
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StockIn',
      theme: NewTheme.darkTheme(),
      routes: routes,
    );
  }
}
