import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockin/global.dart';

import '../size.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).drawerTheme.backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight(20)),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/logo.svg",
                  width: getHeight(16),
                  color: Theme.of(context).primaryColorDark,
                ),
                SizedBox(width: getHeight(10)),
                Text(
                  "STOCKIN",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontSize: getHeight(16),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: getHeight(40)),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => themeChanger.changeTheme(),
                    child: FaIcon(
                      themeChanger.isDarkMode()
                          ? FontAwesomeIcons.moon
                          : Icons.sunny,
                      size: getHeight(16),
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: getHeight(16)),
            Container(
              color: Theme.of(context).primaryColorLight,
              height: getHeight(2),
              width: getHeight(150),
            ),
            SizedBox(height: getHeight(32)),
            DrawerMenu(
              iconPath: "assets/icons/drawer/market.svg",
              title: "Market",
              tap: () {},
            ),
            DrawerMenu(
              iconPath: "assets/icons/drawer/dashboard.svg",
              title: "Dashboard",
              tap: () {},
            ),
            DrawerMenu(
              iconPath: "assets/icons/drawer/portfolio.svg",
              title: "Portfolio",
              tap: () {},
            ),
            DrawerMenu(
              iconPath: "assets/icons/drawer/news.svg",
              title: "News",
              tap: () {},
            ),
            DrawerMenu(
              iconPath: "assets/icons/drawer/settings.svg",
              title: "Settings",
              tap: () {},
            ),
            const Spacer(),
            Container(
              color: Theme.of(context).primaryColorLight,
              height: getHeight(2),
              width: getHeight(150),
            ),
            SizedBox(height: getHeight(16)),
            Text(
              "Team AVSK",
              style: TextStyle(
                fontSize: getHeight(12),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            SizedBox(height: getHeight(16)),
          ],
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.tap,
  }) : super(key: key);
  final String iconPath, title;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: tap,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: getHeight(18),
                  color: Theme.of(context).primaryColorDark,
                ),
                SizedBox(width: getHeight(10)),
                Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontSize: getHeight(14)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: getHeight(16)),
      ],
    );
  }
}
