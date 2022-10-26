import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/home/components/dashboard/indexCard.dart';
import 'package:stockin/theme.dart';

import '../../../size.dart';

class StockMarket extends StatelessWidget {
  StockMarket({
    Key? key,
  }) : super(key: key);
  final List<Map<String, String>> topIndices = [
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "RELIANCE.NS", "name": "Reliance India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
  ];

  final List<Gradient> indexGradients = [
    LinearGradient(colors: [IndexColors.colors[0], IndexColors.colors[1]]),
    LinearGradient(colors: [IndexColors.colors[1], IndexColors.colors[2]]),
    LinearGradient(colors: [IndexColors.colors[2], IndexColors.colors[0]]),
    LinearGradient(colors: [IndexColors.colors[3], IndexColors.colors[4]]),
    LinearGradient(colors: [IndexColors.colors[5], IndexColors.colors[6]]),
    LinearGradient(colors: [IndexColors.colors[6], IndexColors.colors[3]]),
    LinearGradient(colors: [IndexColors.colors[0], IndexColors.colors[1]]),
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
                onTap: () => Navigator.pushNamed(context, "/indices"),
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
                  itemBuilder: (context, index) => IndexCard(
                        code: topIndices[index].entries.first.value,
                        name: topIndices[index].entries.last.value,
                        gradient: indexGradients[index],
                      ),
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
