import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stockin/database/scrapper.dart';
import 'package:stockin/home/components/mmi_info_card_shimmer.dart';

import '../../../global.dart';
import '../../../size.dart';
import 'animated_texts.dart';
import 'market_mood_renderer.dart';
import 'mmi_info_card.dart';

class MarketMood extends StatefulWidget {
  const MarketMood({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  State<MarketMood> createState() => _MarketMoodState();
}

class _MarketMoodState extends State<MarketMood> {
  bool isMarketMoodReady = false;
  late double marketMood;
  late int index;
  late String mood;

  @override
  void initState() {
    getMarketMood().then((value) {
      marketMood =
          double.parse(double.parse(value.toString()).toStringAsFixed(2));
      getMood();
      setState(() {
        isMarketMoodReady = true;
      });
    });
    super.initState();
  }

  void getMood() {
    if (marketMood <= 25) {
      index = 0;
      mood = "Extreme Fear";
    } else if (marketMood <= 50) {
      index = 1;
      mood = "Fear";
    } else if (marketMood <= 75) {
      index = 2;
      mood = "Greed";
    } else {
      index = 3;
      mood = "Extreme Greed";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Theme.of(context).primaryColorLight;
    final Color highlightColor = Theme.of(context).primaryColorDark;

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
                      firstColor: Colors.orangeAccent,
                      secondColor: Colors.greenAccent,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                    MarketMoodRenderer(
                        value: isMarketMoodReady ? marketMood : 0),
                    const AnimatedTexts(
                      first: "Greed",
                      second: "Extreme Greed",
                      firstColor: Colors.deepOrangeAccent,
                      secondColor: Colors.redAccent,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                ),
                if (!isMarketMoodReady)
                  Positioned(
                    left: getWidth(45),
                    right: getWidth(50),
                    top: 270,
                    child: SizedBox(
                      width: 200,
                      height: 100,
                      child: Column(
                        children: [
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: getHeight(60),
                              height: getHeight(25),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withAlpha(20),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          SizedBox(height: getHeight(10)),
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: getHeight(80),
                              height: getHeight(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withAlpha(20),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (isMarketMoodReady)
                  Positioned(
                    left: getWidth(45),
                    right: getWidth(50),
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
                          child: TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1.7),
                            duration: const Duration(milliseconds: 1700),
                            builder: (context, double value, child) {
                              if (value == 1.7) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder(
                                      tween: Tween<double>(
                                          begin: 0.0, end: marketMood),
                                      duration:
                                          const Duration(milliseconds: 1300),
                                      builder: (context, double value, child) =>
                                          Text(
                                        value.toStringAsFixed(2),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: getHeight(20),
                                            fontWeight: FontWeight.bold),
                                      ),
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
                                );
                              } else {
                                return const Text("");
                              }
                            },
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
              if (!isMarketMoodReady)
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: getHeight(140),
                    height: getHeight(30),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight.withAlpha(20),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              if (isMarketMoodReady)
                Text(
                  "$mood Mood",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(24),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              SizedBox(height: getHeight(10)),
              if (!isMarketMoodReady)
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    height: getHeight(60),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight.withAlpha(20),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              if (isMarketMoodReady)
                Text(
                  GlobalParams.suggestions[index],
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: getHeight(18),
                  ),
                ),
              SizedBox(height: getHeight(40)),
              Wrap(
                runAlignment: WrapAlignment.spaceAround,
                spacing: getHeight(20),
                runSpacing: getHeight(20),
                children: [
                  if (!isMarketMoodReady)
                    const MMIInfoCardsShimmer(
                        borderColor: Colors.greenAccent,
                        iconName: "extremeFear"),
                  if (!isMarketMoodReady)
                    const MMIInfoCardsShimmer(
                        borderColor: Colors.redAccent,
                        iconName: "extremeGreed"),
                  if (isMarketMoodReady)
                    const MMIInfoCards(
                      borderColor: Colors.greenAccent,
                      iconName: "extremeFear",
                      zoneName: "Extreme Fear (<25)",
                      zoneInfo:
                          "It suggests a good time to open fresh positions as markets are likely to be oversold and might turn upwards.",
                    ),
                  if (isMarketMoodReady)
                    const MMIInfoCards(
                      borderColor: Colors.redAccent,
                      iconName: "extremeGreed",
                      zoneName: "Extreme Greed (>75)",
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
