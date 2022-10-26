import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../global.dart';
import '../../../size.dart';
import 'quickPortfolio.dart';
import 'recentPortfolio.dart';
import 'summaryColumn.dart';

class PortFolio extends StatelessWidget {
  const PortFolio({Key? key}) : super(key: key);

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
          child: Padding(
            padding: EdgeInsets.all(getHeight(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Top(),
                Middle(),
                Bottom()
                // const Bottom(),
              ],
            ),
          ),
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
        Text(
          "My Portfolio",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(24),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getHeight(20)),
        const QuickPortfolio(
          moreInfo: true,
          title: "Coin",
          price: "+\$10,657,00",
          iconData: FontAwesomeIcons.coins,
        ),
        SizedBox(height: getHeight(20)),
        const QuickPortfolio(
          moreInfo: false,
          title: "Investment",
          price: "+\$1,274,05",
          iconData: FontAwesomeIcons.chartColumn,
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
        Text(
          "Recent activities",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(24),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getHeight(20)),
        const RecentPortfolio(
          title: "Crypto (Bitcoin)",
          value: "+16000",
          progress: 0.7,
          profit: "%12",
          date: "11/09/2022",
          iconData: FontAwesomeIcons.bitcoin,
        ),
        SizedBox(height: getHeight(20)),
        const RecentPortfolio(
          title: "Amazon",
          value: "-2500",
          progress: 0.3,
          profit: "%1.5",
          date: "11/09/2022",
          iconData: FontAwesomeIcons.amazon,
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
          "Summary",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(24),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getHeight(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SummaryColumn(title: "OPEN", price: "81,000"),
                // Spacer(),
                SummaryColumn(title: "PREV CLOSE", price: "72,000"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SummaryColumn(title: "High", price: "12,000"),
                // Spacer(),
                SummaryColumn(title: "LOW", price: "8,000"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SummaryColumn(title: "52WK HIGH", price: "1,000.10"),
                // Spacer(),
                SummaryColumn(title: "52WK LOW", price: "1,000.1"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
