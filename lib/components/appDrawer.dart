import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockin/global.dart';

import '../database/signIn.dart';
import '../size.dart';
import 'drawerMenu.dart';
import 'loginButton.dart';
import 'profileView.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key, required this.changeTab, required this.current})
      : super(key: key);
  final Function changeTab;
  final int current;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool shrink = SizeConfig.width <= 1200;
  bool loggedIn = false, signing = false, isHovered = false;
  User? user;

  List<String> tabs = [
    "Dashboard",
    "Portfolio",
    "Indices",
    "Stocks",
    "Watchlist",
    "About us"
  ];
  List<String> tabIcons = [
    "dashboard",
    "portfolio",
    "market",
    "market",
    "market",
    "news",
  ];
  // late Timer timer;

  // @override
  // void initState() {
  //   super.initState();
  //   timer = Timer.periodic(
  //       const Duration(seconds: 1),
  //       (Timer t) => setState(() {
  //             print(SizeConfig.width);
  //             if (SizeConfig.width <= 1200) {
  //               shrink = true;
  //             } else {
  //               shrink = false;
  //             }
  //           }));
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   timer.cancel();
  // }
//  AnimationController linearAnimationController = AnimationController(
//     duration: const Duration(milliseconds: 1500),
//     vsync: this);

// CurvedAnimation linearAnimation =
//     CurvedAnimation(parent: linearAnimationController, curve: Curves.linear)
//       ..addListener(() {
//         setState(() {
//           animationValue = linearAnimation.value * 360;
//         });
//       });
// linearAnimationController.repeat();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: GlobalParams.duration,
      decoration: BoxDecoration(
        color: Theme.of(context).drawerTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.9),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getHeight(40)),
            if (loggedIn)
              ProfileView(
                shrink: shrink,
                user: user,
              ),
            if (!loggedIn)
              InkWell(
                onTap: () async {
                  setState(() {
                    signing = true;
                  });

                  user = await SignInProvider.googleLogin();

                  setState(() {
                    loggedIn = true;
                  });
                },
                onHover: (value) {
                  setState(() {
                    isHovered = value;
                  });
                },
                borderRadius: BorderRadius.circular(4),
                child: signing
                    ? CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Theme.of(context).primaryColor,
                      )
                    : LoginButton(isHovered: isHovered, shrink: shrink),
              ),
            SizedBox(height: getHeight(20)),
            Container(
              color: Colors.white.withOpacity(0.4),
              width: shrink ? getHeight(30) : getHeight(150),
              height: getHeight(1),
            ),
            SizedBox(height: getHeight(14)),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                      tabs.length,
                      (index) => DrawerMenu(
                          iconPath: tabIcons[index],
                          title: tabs[index],
                          isSelected: widget.current == index,
                          shrink: shrink,
                          tap: () => widget.changeTab(index, false)))
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
