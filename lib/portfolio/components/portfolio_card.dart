import 'package:flutter/material.dart';

import '../../size.dart';

class PortfolioCard extends StatelessWidget {
  const PortfolioCard({
    Key? key,
    required this.value,
    required this.title,
    required this.checkSign,
  }) : super(key: key);
  final String title;
  final double value;
  final bool checkSign;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: checkSign
            ? value >= 0
                ? Colors.greenAccent.withOpacity(0.05)
                : Colors.redAccent.withOpacity(0.05)
            : Theme.of(context).drawerTheme.backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: EdgeInsets.all(getHeight(16)),
        child: Column(
          children: [
            Text(
              value.toStringAsFixed(2),
              style: TextStyle(
                  color: checkSign
                      ? value >= 0
                          ? Colors.greenAccent
                          : Colors.redAccent
                      : Theme.of(context).primaryColorDark,
                  fontSize: getHeight(20),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
          ],
        ),
      ),
    );
  }
}
