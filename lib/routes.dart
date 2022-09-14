import 'package:flutter/material.dart';

import 'Home/home.dart';
import 'stock/stock.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const Home(),
  "/home": (context) => const Home(),
  "/stock": (context) => const Stock(),
};
