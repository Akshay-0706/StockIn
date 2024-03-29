import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  static bool isThemeDark = true;

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
  // static ThemeData lightTheme() {
  //   return ThemeData(
  //     fontFamily: "OverPass",
  //     brightness: Brightness.light,
  //     appBarTheme: AppBarTheme(
  //       elevation: 0,
  //       backgroundColor: Global.background,
  //       iconTheme: IconThemeData(color: Global.foreground),
  //     ),
  //     drawerTheme: DrawerThemeData(backgroundColor: Global.drawerBg),
  //     textTheme: lightTextTheme(),
  //     scaffoldBackgroundColor: Global.background,
  //     backgroundColor: Global.background,
  //     primaryColor: Global.primary,
  //     primaryColorLight: Global.foregroundAlt,
  //     primaryColorDark: Global.foreground,
  //   );
  // }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: "OverPass",
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Global.backgroundDark,
        iconTheme: IconThemeData(color: Global.foregroundDark),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF131C2D).withOpacity(0.7),
        shadowColor: Global.drawerBgDark,
        elevation: 4,
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

  // static TextTheme lightTextTheme() {
  //   return TextTheme(
  //     headline1: TextStyle(color: Global.primary),
  //     // headline2: TextStyle(color: Global.primaryAlt),
  //     bodyText1: TextStyle(color: Global.foreground),
  //     bodyText2: TextStyle(color: Global.foregroundAlt),
  //   );
  // }

  static TextTheme darkTextTheme() => TextTheme(
        headline1: TextStyle(color: Global.primaryDark),
        // headline2: TextStyle(color: Global.primaryAltDark),
        bodyText1: TextStyle(color: Global.foregroundDark),
        bodyText2: TextStyle(color: Global.foregroundAltDark),
      );
}

class Global {
  // Light mode colors
  // static Color primary = const Color(0xFF1B98E0);
  // static Color foreground = Colors.black;
  // static Color foregroundAlt = Colors.black54;
  // static Color background = Color(0xFFC9E9EC);
  // static Color drawerBg = Color(0xFFE2F5F7);

  // Dark mode colors
  static Color? primaryDark = const Color(0xFF1B98E0);
  static Color foregroundDark = Colors.white;
  static Color foregroundAltDark = Colors.white54;
  static Color backgroundDark = const Color(0xFF040404);
  static Color drawerBgDark = const Color(0xFF202020);
}

class IndexColors {
  // Stock colors
  static List<Color> colors = [
    // const Color(0xFFEBA49C),
    // const Color(0xFFF04394),
    // const Color(0xFFF9C449),
    // const Color(0xFF7BD5F5),
    // const Color(0xFF1CA7EC),
    // const Color(0xFF7B7FF6),
    // const Color(0xFF1F2F98),

    const Color(0xFFFACD68),
    const Color(0xFFFC76B3),
    const Color(0xFFF9C449),
    const Color(0xFF7BD5F5),
    const Color(0xFF1CA7EC),
    const Color(0xFF7B7FF6),
    const Color(0xFF1F2F98),
  ];

  static final List<Gradient> indexGradients = [
    LinearGradient(
      colors: [colors[0], colors[1]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [colors[1], colors[2]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [colors[2], colors[3]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [colors[3], colors[4]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [colors[4], colors[5]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [colors[5], colors[6]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];
}
