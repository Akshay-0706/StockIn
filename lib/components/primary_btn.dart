import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../global.dart';
import '../size.dart';

class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn({
    Key? key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.padding,
    required this.title,
    required this.tap,
    required this.titleColor,
    required this.hasIcon,
    this.iconData = FontAwesomeIcons.google,
    this.iconColor = Colors.white,
  }) : super(key: key);
  final Color primaryColor, secondaryColor, titleColor, iconColor;
  final double padding;
  final String title;
  final GestureTapCallback tap;
  final bool hasIcon;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: InkWell(
        onTap: tap,
        borderRadius: BorderRadius.circular(20),
        splashColor: primaryColor,
        child: Ink(
          height: getHeight(50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    secondaryColor,
                  ],
                  stops: const [
                    0,
                    1
                  ]),
              boxShadow: [
                BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(3, 5))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasIcon)
                Center(
                  child: FaIcon(
                    iconData,
                    color: iconColor,
                    size: getHeight(16),
                  ),
                ),
              if (hasIcon) SizedBox(width: getHeight(10)),
              Text(
                title,
                style: TextStyle(
                    color: titleColor,
                    fontSize: getHeight(16),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
