import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size.dart';
import 'popularCard.dart';
import 'stockCard.dart';
import 'transaction.dart';

class First extends StatelessWidget {
  const First({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getHeight(20),
        left: getHeight(40),
        right: getHeight(20),
        bottom: getHeight(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Top(),
          Middle(),
          Bottom(),
        ],
      ),
    );
  }
}

class Top extends StatelessWidget {
  const Top({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Stock Market",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(36),
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "Trending market group",
          style: TextStyle(fontSize: getHeight(14)),
        ),
        SizedBox(height: getHeight(20)),
        Row(
          children: [
            const Spacer(),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/indices"),
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
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
              child: Row(
                children: [
                  const StockCard(),
                  SizedBox(width: getHeight(20)),
                  const StockCard(),
                  SizedBox(width: getHeight(20)),
                  const StockCard(),
                  SizedBox(width: getHeight(20)),
                  const StockCard(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Middle extends StatelessWidget {
  const Middle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Most popular week",
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getHeight(26),
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            const FaIcon(Icons.more_horiz_rounded)
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
              child: Row(
                children: [
                  const PopularCard(),
                  SizedBox(width: getHeight(20)),
                  const PopularCard(),
                  SizedBox(width: getHeight(20)),
                  const PopularCard(),
                  SizedBox(width: getHeight(20)),
                  const PopularCard(),
                  SizedBox(width: getHeight(20)),
                  const PopularCard(),
                  SizedBox(width: getHeight(20)),
                  const PopularCard(),
                  SizedBox(width: getHeight(20)),
                  const PopularCard(),
                  SizedBox(width: getHeight(20)),
                ],
              ),
            ),
          ),
        ),
      ],
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
