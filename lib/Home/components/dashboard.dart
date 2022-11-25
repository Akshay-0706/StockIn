import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/global.dart';

import '../../../size.dart';
import '../../components/nav_bar.dart';
import 'market_mood.dart';
import 'popular_week.dart';
import 'stock_market.dart';

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
                  Theme.of(context).backgroundColor.withOpacity(0.5),
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
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: getHeight(40),
                      right: getHeight(40),
                      top: getHeight(40),
                    ),
                    child: NavBar(changeTab: changeTab),
                  ),
                  SizedBox(height: getHeight(40)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getHeight(40)),
                    child: MarketMood(context: context),
                  ),
                  SizedBox(height: getHeight(20)),
                  StockMarket(changeTab: changeTab),
                  SizedBox(height: getHeight(20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getHeight(40)),
                    child: PopularWeek(trend: "Gainer", changeTab: changeTab),
                  ),
                  SizedBox(height: getHeight(20)),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getHeight(40),
                      right: getHeight(40),
                      bottom: getHeight(40),
                    ),
                    child: PopularWeek(trend: "Loser", changeTab: changeTab),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
