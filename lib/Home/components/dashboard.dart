import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/components/navBar.dart';
import 'package:stockin/global.dart';

import '../../../size.dart';
import 'marketMood.dart';
import 'popularWeek.dart';
import 'stockMarket.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({
    Key? key,
    required this.changeTab,
  }) : super(key: key);
  final Function changeTab;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: GlobalParams.duration,
      builder: (context, double value, child) => Opacity(
        opacity: value,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Theme.of(context).backgroundColor,
                  const Color(0xFF131C2D).withOpacity(0.7),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(getHeight(40)),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NavBar(
                      changeTab: changeTab,
                    ),
                    SizedBox(height: getHeight(40)),
                    MarketMood(
                      context: context,
                      marketMood: 587,
                    ),
                    SizedBox(height: getHeight(20)),
                    StockMarket(changeTab: changeTab),
                    SizedBox(height: getHeight(40)),
                    PopularWeek(changeTab: changeTab),
                    // const Bottom(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}