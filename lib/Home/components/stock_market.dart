import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/home/components/index_card_shimmer.dart';
import 'package:stockin/theme.dart';

import '../../../size.dart';
import 'index_card.dart';

class StockMarket extends StatefulWidget {
  StockMarket({
    Key? key,
    required this.changeTab,
  }) : super(key: key);
  final Function changeTab;

  @override
  State<StockMarket> createState() => _StockMarketState();
}

class _StockMarketState extends State<StockMarket> {
  bool areIndicesReady = true;
  final List<Map<String, String>> topIndices = [
    {"name": "Nifty 50", "change": "Nifty 50"},
    {"name": "Sensex", "change": "Sensex"},
    {"name": "Nifty FMCG", "change": "Nifty 100"},
    {"name": "Nifty IT", "change": "Nifty IT"},
    {"name": "Nifty Pharma", "change": "Nifty 200"},
    {"name": "Nifty Bank", "change": "Nifty 500"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                  "Trending market group",
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
                onTap: () => widget.changeTab(2, false),
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
        SizedBox(height: getHeight(20)),
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
            child: SizedBox(
              width: getHeight(220) * topIndices.length +
                  getHeight(20) * (topIndices.length - 1),
              height: getHeight(120),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => areIndicesReady
                      ? IndexCard(
                          name: topIndices[index].entries.first.value,
                          change: topIndices[index].entries.last.value,
                          gradient: IndexColors.indexGradients[index],
                        )
                      : IndexCardShimmer(
                          gradient: IndexColors.indexGradients[index]),
                  separatorBuilder: (context, index) =>
                      SizedBox(width: getHeight(20)),
                  itemCount: topIndices.length),
            ),
          ),
        ),
      ],
    );
  }
}
