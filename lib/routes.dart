import 'package:flutter/material.dart';

import 'Home/home.dart';
import 'indices/indices.dart';
import 'stock/stock.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const Home(),
  "/home": (context) => const Home(),
  "/stock": (context) => const Stock(),
  "/indices": (context) => const Indices(),
};
