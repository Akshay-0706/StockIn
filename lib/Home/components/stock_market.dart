import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/home/components/index_card_shimmer.dart';
import 'package:stockin/theme.dart';

import '../../../size.dart';
import '../../database/server/api.dart';
import 'index_card.dart';

class StockMarket extends StatefulWidget {
  const StockMarket({
    Key? key,
    required this.changeTab,
  }) : super(key: key);
  final Function changeTab;

  @override
  State<StockMarket> createState() => _StockMarketState();
}

class _StockMarketState extends State<StockMarket> {
  bool areIndicesReady = false;
  late List<Map<String, dynamic>> topIndices;
  late Color? color;
  late Timer timer;
  late List<double> indices = [];
  List<String> topIndicesId = [
    "SX",
    "N50",
    "NB",
    "NIT",
    "NF",
    "NP",
  ];
  List<String> topIndicesNames = [
    "Sensex",
    "Nifty 50",
    "Nifty Bank",
    "Nifty IT",
    "Nifty FMCG",
    "Nifty Pharma",
  ];

  void getIndices() {
    // print("Called");
    fetchTopIndices().then((value) {
      topIndices = value.topIndices;
      if (mounted) {
        setState(() {
          areIndicesReady = true;
        });
      }
    });
  }

  @override
  void initState() {
    getIndices();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => getIndices());

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getHeight(40)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stock Market",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: getHeight(32),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Indicesindicesing market group",
                    style: TextStyle(
                      fontSize: getHeight(14),
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => widget.changeTab(3, false),
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(40)),
              child: Row(
                children: [
                  ...List.generate(
                    6,
                    (index) {
                      if (areIndicesReady) {
                        color = indices.length != topIndices.length
                            ? null
                            : indices[index] ==
                                    double.parse(topIndices[index]
                                        .entries
                                        .first
                                        .value
                                        .toString()
                                        .replaceAll(",", ""))
                                ? null
                                : double.parse(topIndices[index]
                                            .entries
                                            .first
                                            .value
                                            .toString()
                                            .replaceAll(",", "")) >
                                        indices[index]
                                    ? Colors.green.withAlpha(150)
                                    : Colors.red.withAlpha(150);

                        if (indices.length != topIndices.length) {
                          indices.add(double.parse(topIndices[index]
                              .entries
                              .first
                              .value
                              .toString()
                              .replaceAll(",", "")));
                        }

                        indices[index] = double.parse(topIndices[index]
                            .entries
                            .first
                            .value
                            .toString()
                            .replaceAll(",", ""));
                      }

                      if (areIndicesReady) {
                        return IndexCard(
                          index: index,
                          length: topIndices.length,
                          id: topIndicesId[index],
                          name: topIndicesNames[index],
                          volume: topIndices[index]
                              .entries
                              .first
                              .value
                              .toString()
                              .replaceAll(",", ""),
                          change: (double.parse(topIndices[index]
                                  .entries
                                  .last
                                  .value
                                  .toString()))
                              .toStringAsFixed(2),
                          gradient: IndexColors.indexGradients[index],
                          color: color,
                        );
                      } else {
                        return IndexCardShimmer(
                            index: index,
                            length: 6,
                            gradient: IndexColors.indexGradients[index]);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
