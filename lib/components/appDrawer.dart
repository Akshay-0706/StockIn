import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockin/global.dart';

import '../size.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key, required this.changeTab}) : super(key: key);
  final Function changeTab;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int current = 0;

  List<String> tabs = ["Dashboard", "Portfolio", "Market", "News", "Settings"];
  List<String> tabIcons = [
    "dashboard",
    "portfolio",
    "market",
    "news",
    "settings"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).drawerTheme.backgroundColor,
        boxShadow: const [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
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
                  width: getHeight(18),
                  color: Theme.of(context).primaryColorDark,
                ),
                SizedBox(width: getHeight(10)),
                Text(
                  "STOCKIN",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontSize: getHeight(18),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: getHeight(80)),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => themeChanger.changeTheme(),
                    child: FaIcon(
                      themeChanger.isDarkMode()
                          ? FontAwesomeIcons.moon
                          : Icons.sunny,
                      size: getHeight(18),
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
              width: getHeight(200),
            ),
            SizedBox(height: getHeight(32)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                    5,
                    (index) => DrawerMenu(
                        iconPath: "assets/icons/drawer/${tabIcons[index]}.svg",
                        title: tabs[index],
                        isSelected: current == index,
                        tap: () {
                          widget.changeTab(index);
                          current = index;
                        }))
              ],
            ),
            const Spacer(),
            Container(
              color: Theme.of(context).primaryColorLight,
              height: getHeight(2),
              width: getHeight(200),
            ),
            SizedBox(height: getHeight(16)),
            Text(
              "Team AVSK",
              style: TextStyle(
                fontSize: getHeight(14),
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
    required this.isSelected,
  }) : super(key: key);
  final String iconPath, title;
  final bool isSelected;
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
                      fontSize: getHeight(16)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: getHeight(24)),
      ],
    );
  }
}
