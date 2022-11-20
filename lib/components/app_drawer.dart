import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockin/database/jwt.dart';
import 'package:stockin/global.dart';

import '../database/sign_in.dart';
import '../size.dart';
import 'drawer_menu.dart';
import 'login_button.dart';
import 'primary_btn.dart';
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
  late String token;
  bool prefIsReady = false,
      shrink = SizeConfig.width <= 1200,
      isDialogShown = false;
  late bool loggedIn;
  bool logginIn = false,
      logginOut = false,
      deleting = false,
      isLoginHovered = false,
      isLogoutHovered = false,
      isDeleteHovered = false;
  User? user;

  List<String> explore = [
    "Dashboard",
    "Portfolio",
  ];
  List<String> exploreIcons = [
    "dashboard",
    "portfolio",
  ];

  List<String> stockNIndices = [
    "Stocks",
    "Indices",
  ];
  List<String> stockNIndicesIcons = [
    "stocks",
    "indices",
  ];

  late Timer timer;

  @override
  void initState() {
    sharedPrefInstance.then((value) {
      pref = value;
      setState(() {
        prefIsReady = true;
        loggedIn = pref.containsKey("email");
        token = pref.getString("token")!;
      });
    });

    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (loggedIn) {
        if (!JwtDecoder.isExpired(token)) {
          isDialogShown = false;
        }
        if (JwtDecoder.isExpired(token) && !isDialogShown) {
          isDialogShown = true;
          setState(() {
            loggedIn = false;
          });
          await Auth.googleLogout();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                title: Text(
                  "Session expired!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(20),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      "assets/design/token_expired.json",
                      repeat: false,
                      width: getHeight(200),
                      height: getHeight(200),
                    ),
                    Text(
                      "Please login again",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.8),
                        fontSize: getHeight(18),
                      ),
                    ),
                    SizedBox(height: getHeight(20)),
                    PrimaryBtn(
                      primaryColor: Theme.of(context).primaryColorDark,
                      secondaryColor:
                          Theme.of(context).primaryColorDark.withOpacity(0.8),
                      padding: 20,
                      title: "OK",
                      tap: () {
                        Navigator.pop(context);
                      },
                      titleColor: Theme.of(context).backgroundColor,
                      hasIcon: false,
                    ),
                  ],
                ),
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            ),
          );
        }
      }
    });
  }

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
    int currentSection = widget.current == 4
        ? 2
        : widget.current <= 1
            ? 0
            : 1;

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getHeight(40)),
          Row(
            children: [
              SizedBox(width: getHeight(20)),
              SvgPicture.asset(
                "assets/icons/logo.svg",
                width: getHeight(20),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: getHeight(10)),
              Text(
                "StockIn",
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: getHeight(20)),
          Divider(
            color: Colors.white.withOpacity(0.2),
          ),
          SizedBox(height: getHeight(20)),
          if (!prefIsReady) const CircularProgressIndicator(),
          if (prefIsReady && loggedIn)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
              child: ProfileView(shrink: shrink, pref: pref),
            ),
          if (prefIsReady && !loggedIn)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    logginIn = true;
                  });

                  user = await Auth.googleLogin();
                  // print("Start");
                  // print("Token");
                  // print("Generation...");

                  token = await JWT.signTheToken(user!);

                  globalToken.setToken(token);
                  // print("Done!");

                  pref.setString("email", user!.email!);
                  pref.setString("name", user!.displayName!);
                  pref.setString("image", user!.photoURL!);
                  pref.setString("token", token);

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
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 3.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      )
                    : Button(
                        icon: FontAwesomeIcons.arrowRightToBracket,
                        isHovered: isLoginHovered,
                        shrink: shrink),
              ),
            ),
          SizedBox(height: getHeight(20)),
          Divider(
            color: Colors.white.withOpacity(0.2),
          ),
          // Container(
          //   color: Colors.white.withOpacity(0.4),
          //   width: shrink ? getHeight(30) : getHeight(150),
          //   height: getHeight(1),
          // ),
          SizedBox(height: getHeight(7)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
            child: Text(
              "Explore & Watch",
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
                fontSize: getHeight(14),
              ),
            ),
          ),
          SizedBox(height: getHeight(7)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  explore.length,
                  (index) => DrawerMenu(
                    iconPath: exploreIcons[index],
                    title: explore[index],
                    isSelected: widget.current == index && currentSection == 0,
                    shrink: shrink,
                    tap: () => widget.changeTab(index, false),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: getHeight(7)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
            child: Text(
              "Stocks & Indices",
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
                fontSize: getHeight(14),
              ),
            ),
          ),
          SizedBox(height: getHeight(7)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  stockNIndices.length,
                  (index) => DrawerMenu(
                    iconPath: stockNIndicesIcons[index],
                    title: stockNIndices[index],
                    isSelected:
                        widget.current == index + 2 && currentSection == 1,
                    shrink: shrink,
                    tap: () => widget.changeTab(index + 2, false),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
            child: Text(
              "Read more",
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
                fontSize: getHeight(14),
              ),
            ),
          ),
          SizedBox(height: getHeight(7)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
            child: DrawerMenu(
              iconPath: "about_us",
              title: "About us",
              isSelected: currentSection == 2,
              shrink: shrink,
              tap: () => widget.changeTab(4, false),
            ),
          ),
          const Spacer(),
          Divider(
            color: Colors.white.withOpacity(0.2),
          ),
          SizedBox(height: getHeight(20)),
          if (prefIsReady && loggedIn)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  direction: shrink ? Axis.vertical : Axis.horizontal,
                  spacing: getHeight(20),
                  children: [
                    InkWell(
                      onTap: () async {
                        setState(() {
                          logginOut = true;
                        });
                        await Auth.googleLogout();
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
                        await Auth.googleDelete(pref.getString("email")!);
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
              ],
            ),
          SizedBox(height: getHeight(20)),
        ],
      ),
    );
  }
}
