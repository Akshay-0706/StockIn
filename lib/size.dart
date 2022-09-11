import 'package:flutter/cupertino.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  static late double width;
  static late double height;
  static late Orientation orientation;
  static late Display display;

  SizeConfig(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
    orientation = mediaQueryData.orientation;
    if (width >= 1100) {
      display = Display.desktop;
    } else if (width >= 850) {
      display = Display.tab;
    } else {
      display = Display.mobile;
    }
  }
}

getWidth(double width) => (width / 375.0) * SizeConfig.width;
getHeight(double height) => (height / 812.0) * SizeConfig.height;

enum Display {
  mobile,
  tab,
  desktop,
}
