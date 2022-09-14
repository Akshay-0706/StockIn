import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size.dart';

class RecentPortfolio extends StatelessWidget {
  const RecentPortfolio({
    Key? key,
    required this.title,
    required this.value,
    required this.profit,
    required this.date,
    required this.iconData,
    required this.progress,
  }) : super(key: key);
  final String title, value, profit, date;
  final IconData iconData;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            FaIcon(
              iconData,
              color: Theme.of(context).primaryColorDark,
            ),
            SizedBox(width: getHeight(10)),
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(14)),
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(14),
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(height: getHeight(10)),
        LinearProgressIndicator(
          value: progress,
          color: Theme.of(context).primaryColorDark,
          backgroundColor: Theme.of(context).primaryColorLight.withOpacity(0.2),
        ),
        SizedBox(height: getHeight(10)),
        Row(
          children: [
            Text(
              "Profit",
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getHeight(14)),
            ),
            SizedBox(width: getHeight(10)),
            Text(
              profit,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(14),
                  fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Text(
              date,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getHeight(14),
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}
