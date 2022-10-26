import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stockin/components/navBar.dart';
import 'package:stockin/global.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../size.dart';
import 'animatedTexts.dart';
import 'marketMood.dart';
import 'popularWeek.dart';
import 'stockMarket.dart';
import 'transaction.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({
    Key? key,
  }) : super(key: key);

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
                    const NavBar(),
                    SizedBox(height: getHeight(40)),
                    marketMoodBuilder(context, 60),
                    SizedBox(height: getHeight(40)),
                    StockMarket(),
                    SizedBox(height: getHeight(40)),
                    PopularWeek(),

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

  Row marketMoodBuilder(BuildContext context, double marketMood) {
    late int index;
    late String mood;
    if (marketMood < 25) {
      index = 0;
      mood = "Extreme Fear";
    } else if (marketMood < 50) {
      index = 1;
      mood = "Fear";
    } else if (marketMood < 75) {
      index = 2;
      mood = "Greed";
    } else {
      index = 3;
      mood = "Extreme Greed";
    }

    return Row(
      children: [
        Column(
          children: [
            Text(
              "Market Mood Index",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: getHeight(32),
                fontWeight: FontWeight.w700,
              ),
            ),
            Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AnimatedTexts(
                      first: "Fear",
                      second: "Extreme Fear",
                      firstColor: Colors.greenAccent,
                      secondColor: Colors.orangeAccent,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                    MarketMood(value: marketMood),
                    const AnimatedTexts(
                      first: "Greed",
                      second: "Extreme Greed",
                      firstColor: Colors.deepOrangeAccent,
                      secondColor: Colors.redAccent,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                ),
                Positioned(
                  left: 180,
                  top: 250,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 1),
                    builder: (context, double value, child) => Opacity(
                      opacity: value,
                      child: Container(
                        width: 200,
                        height: 100,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              marketMood.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: getHeight(20),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Updated today",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(0.7),
                                fontSize: getHeight(14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(width: getHeight(60)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$mood Mood",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(24),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: getHeight(10)),
              Text(
                GlobalParams.suggestions[index],
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getHeight(18),
                ),
              ),
              SizedBox(height: getHeight(40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  MMIInfoCards(
                    borderColor: Colors.greenAccent,
                    iconName: "extremeFear",
                    zoneName: "Extreme Fear (<25)",
                    zoneInfo:
                        "It suggests a good time to open fresh positions as markets are likely to be oversold and might turn upwards.",
                  ),
                  MMIInfoCards(
                    borderColor: Colors.redAccent,
                    iconName: "extremeGreed",
                    zoneName: "Extreme Greed (>100)",
                    zoneInfo:
                        "It suggests to be cautious in opening fresh positions as markets are overbought and likely to turn downwards.",
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class MMIInfoCards extends StatelessWidget {
  const MMIInfoCards({
    Key? key,
    required this.borderColor,
    required this.iconName,
    required this.zoneName,
    required this.zoneInfo,
  }) : super(key: key);
  final Color borderColor;
  final String iconName, zoneName, zoneInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 130,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getHeight(10)),
                  Row(
                    children: [
                      SvgPicture.asset("assets/design/$iconName.svg"),
                      SizedBox(width: getHeight(10)),
                      Text(zoneName)
                    ],
                  ),
                  SizedBox(height: getHeight(20)),
                  Text(zoneInfo),
                  SizedBox(height: getHeight(10)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Bottom extends StatelessWidget {
  const Bottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Transaction",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(26),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getHeight(20)),
        const Transaction(),
        SizedBox(height: getHeight(20)),
        const Transaction(),
      ],
    );
  }
}
