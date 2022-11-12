import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockin/global.dart';

import '../database/sign_in.dart';
import '../size.dart';
import 'drawer_menu.dart';
import 'login_button.dart';
import 'profile_view.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key, required this.changeTab, required this.current})
      : super(key: key);
  final Function changeTab;
  final int current;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final Future<SharedPreferences> sharedPrefInstance =
      SharedPreferences.getInstance();
  late SharedPreferences pref;
  bool prefIsReady = false, shrink = SizeConfig.width <= 1200;
  late bool loggedIn;
  bool logginIn = false,
      logginOut = false,
      deleting = false,
      isLoginHovered = false,
      isLogoutHovered = false,
      isDeleteHovered = false;
  User? user;

  List<String> tabs = [
    "Dashboard",
    "Portfolio",
    "Indices",
    "Stocks",
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

  @override
  void initState() {
    sharedPrefInstance.then((value) {
      pref = value;
      setState(() {
        prefIsReady = true;
        loggedIn = pref.containsKey("email");
      });
    });

    super.initState();

    // timer = Timer.periodic(
    //     const Duration(seconds: 1),
    //     (Timer t) => setState(() {
    //           print(SizeConfig.width);
    //           if (SizeConfig.width <= 1200) {
    //             shrink = true;
    //           } else {
    //             shrink = false;
    //           }
    //         }));
  }

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
            if (!prefIsReady) const CircularProgressIndicator(),
            if (prefIsReady && loggedIn)
              ProfileView(shrink: shrink, pref: pref),
            if (prefIsReady && !loggedIn)
              InkWell(
                onTap: () async {
                  setState(() {
                    logginIn = true;
                  });

                  user = await SignInProvider.googleLogin();

                  pref.setString("email", user!.email!);
                  pref.setString("name", user!.displayName!);
                  pref.setString("image", user!.photoURL!);

                  setState(() {
                    loggedIn = true;
                    logginIn = false;
                  });
                },
                onHover: (value) {
                  setState(() {
                    isLoginHovered = value;
                  });
                },
                borderRadius: BorderRadius.circular(4),
                child: logginIn
                    ? CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Theme.of(context).primaryColor,
                      )
                    : Button(
                        icon: FontAwesomeIcons.arrowRightToBracket,
                        isHovered: isLoginHovered,
                        shrink: shrink),
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
            if (prefIsReady && loggedIn)
              Wrap(
                direction: shrink ? Axis.vertical : Axis.horizontal,
                spacing: getHeight(20),
                children: [
                  InkWell(
                    onTap: () async {
                      setState(() {
                        logginOut = true;
                      });
                      await SignInProvider.googleLogout();
                      setState(() {
                        logginOut = false;
                        loggedIn = false;
                      });
                    },
                    onHover: (value) {
                      setState(() {
                        isLogoutHovered = value;
                      });
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: logginOut
                        ? const CircularProgressIndicator()
                        : Button(
                            icon: FontAwesomeIcons.arrowRightFromBracket,
                            isHovered: isLogoutHovered,
                            shrink: true,
                          ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        deleting = true;
                      });
                      // print("Email: ")
                      await SignInProvider.googleDelete(
                          pref.getString("email")!);
                      setState(() {
                        deleting = false;
                        loggedIn = false;
                      });
                    },
                    onHover: (value) {
                      setState(() {
                        isDeleteHovered = value;
                      });
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: deleting
                        ? const CircularProgressIndicator()
                        : Button(
                            icon: Icons.delete,
                            isHovered: isDeleteHovered,
                            shrink: true,
                          ),
                  ),
                ],
              ),
            SizedBox(height: getHeight(20)),
          ],
        ),
      ),
    );
  }
}
