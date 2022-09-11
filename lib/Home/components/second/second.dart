import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size.dart';
import 'quickPortfolio.dart';
import 'recentPortfolio.dart';
import 'summaryColumn.dart';

class Second extends StatelessWidget {
  const Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getHeight(20),
        left: getHeight(20),
        right: getHeight(40),
        bottom: getHeight(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
