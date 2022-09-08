import 'package:flutter/material.dart';

import 'Home/Home.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const Home(),
  "/home": (context) => const Home(),
};
