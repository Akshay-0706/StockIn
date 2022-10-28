library config.globals;

import 'package:stockin/theme.dart';

ThemeChanger themeChanger = ThemeChanger();

class GlobalParams {
  static Duration duration = const Duration(milliseconds: 400);
  static String ngrok = "https://2d3a-43-250-209-165.in.ngrok.io";
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
}
