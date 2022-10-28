import 'package:flutter/material.dart';
import 'package:stockin/about/about.dart';
import 'package:stockin/watchlist/watchlist.dart';

import 'Home/home.dart';
import 'indices/indices.dart';
import 'stock/stock.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const Home(),
  "/home": (context) => const Home(),
};
