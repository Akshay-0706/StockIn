import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  static bool isThemeDark = false;

  bool isDarkMode() => isThemeDark;

  ThemeMode currentTheme() {
    return isThemeDark ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    isThemeDark = !isThemeDark;
    notifyListeners();
  }
}

class NewTheme {
  static ThemeData lightTheme()  {
    return ThemeData(
      fontFamily: "OverPass",
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Global.background,
        iconTheme: IconThemeData(color: Global.foreground),
      ),
      drawerTheme: DrawerThemeData(backgroundColor: Global.drawerBg),
      textTheme: lightTextTheme(),
      scaffoldBackgroundColor: Global.background,
      backgroundColor: Global.background,
      primaryColor: Global.primary,
      primaryColorLight: Global.foregroundAlt,
      primaryColorDark: Global.foreground,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: "OverPass",
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Global.backgroundDark,
        iconTheme: IconThemeData(color: Global.foregroundDark),
      ),
      drawerTheme: DrawerThemeData(backgroundColor: Global.drawerBgDark),
      textTheme: darkTextTheme(),
      scaffoldBackgroundColor: Global.backgroundDark,
      backgroundColor: Global.backgroundDark,
      primaryColor: Global.primaryDark,
      primaryColorLight: Global.foregroundAltDark,
      primaryColorDark: Global.foregroundDark,
    );
  }

  static TextTheme lightTextTheme() {
    return TextTheme(
      headline1: TextStyle(color: Global.primary),
      // headline2: TextStyle(color: Global.primaryAlt),
      bodyText1: TextStyle(color: Global.foreground),
      bodyText2: TextStyle(color: Global.foregroundAlt),
    );
  }

  static TextTheme darkTextTheme() => TextTheme(
        headline1: TextStyle(color: Global.primaryDark),
        // headline2: TextStyle(color: Global.primaryAltDark),
        bodyText1: TextStyle(color: Global.foregroundDark),
        bodyText2: TextStyle(color: Global.foregroundAltDark),
      );
}

class Global {
  // Light mode colors
  static Color primary = const Color(0xff42C2FF);
  static Color foreground = Colors.black;
  static Color foregroundAlt = Colors.black54;
  static Color background = Colors.white;
  static Color drawerBg = const Color.fromRGBO(248, 248, 248, 1);

  // Dark mode colors
  static Color? primaryDark = Colors.greenAccent[400];
  static Color foregroundDark = Colors.white;
  static Color foregroundAltDark = Colors.white54;
  static Color backgroundDark = const Color.fromARGB(255, 0, 10, 0);
  static Color drawerBgDark = const Color.fromRGBO(20, 20, 20, 1);
}
