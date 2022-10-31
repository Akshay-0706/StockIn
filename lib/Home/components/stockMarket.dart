import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/theme.dart';

import '../../../size.dart';
import 'indexCard.dart';

class StockMarket extends StatelessWidget {
  StockMarket({
    Key? key,
    required this.changeTab,
  }) : super(key: key);
  final Function changeTab;

  final List<Map<String, String>> topIndices = [
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "RELIANCE.NS", "name": "Reliance India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
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
                onTap: () => changeTab(2, false),
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
                        gradient: IndexColors.indexGradients[index],
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
