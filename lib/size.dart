import 'package:flutter/cupertino.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  static late double width;
  static late double height;
  static late Orientation orientation;

  SizeConfig(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
    orientation = mediaQueryData.orientation;
  }
}

getWidth(double width) => (width / 375.0) * SizeConfig.width;
getHeight(double height) => (height / 812.0) * SizeConfig.height;
