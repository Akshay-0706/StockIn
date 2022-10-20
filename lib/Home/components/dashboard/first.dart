import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockin/components/navBar.dart';

import '../../../size.dart';
import 'popularCard.dart';
import 'stockCard.dart';
import 'transaction.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Theme.of(context).backgroundColor.withOpacity(0.1),
              Theme.of(context).backgroundColor,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.all(getHeight(40)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            NavBar(),
            Top(),
            Middle(),
            Bottom(),
          ],
        ),
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
        Row(
          children: [
            Column(
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
            child: Row(
              children: [
                const StockCard(),
                SizedBox(width: getHeight(20)),
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/indices"),
                child: Text(
                  "More",
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
                const PopularCard(),
                SizedBox(width: getHeight(20)),
                const PopularCard(),
                SizedBox(width: getHeight(20)),
                const PopularCard(),
              ],
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
