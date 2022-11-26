library config.globals;

import 'package:stockin/database/data/token.dart';
import 'package:stockin/theme.dart';

ThemeChanger themeChanger = ThemeChanger();

Token globalToken = Token();

class GlobalParams {
  static Duration duration = const Duration(milliseconds: 400);

  static String server = "http://localhost:3000";

  static List<String> suggestions = [
    "High extreme fear (<25) suggests a good time to open fresh positions, as markets are likely to be oversold and might turn upwards.",
    "It suggests that investors are fearful in the market, but the action to be taken depends on the MMI trajectory.",
    "It suggests that investors are acting greedy in the market, but the action to be taken depends on the MMI trajectory.",
    "High extreme greed (>75) suggests investors should avoid opening fresh positions as markets are overbought and likely to turn downwards."
  ];

  static List<String> navBarQuotes = [
    "StockIn gives accurate results",
    "Check market mood first, then decide",
    "Do not depend on previous data too much",
    "Have faith in yourself"
  ];

  static String aboutInfo =
      "Our mission is to be a go-to website for Stock Analysis. Our goal is to help more people from more backgrounds experience the Stock Market. We believe that in todays world, stock market plays a crucial role in ones financial condition and hence is important for the people to learn and analyze the market for their gains.";

  static List<String> aboutExcel = [
    "Real Time stock prices with candlestick charts.",
    "Live Heat Map for Indices with visible gradient colors.",
    "Track your Portfolio, keep your stocks in track.",
    "Check today's market mood to stay updated."
  ];
}
