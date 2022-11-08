import 'package:flutter/material.dart';

import 'portfolio_card.dart';

class PortfolioCards extends StatelessWidget {
  const PortfolioCards({
    Key? key,
    required this.totalInvestment,
    required this.currentInvestment,
    required this.totalTodaysPnl,
    required this.totalPnl,
  }) : super(key: key);

  final double totalInvestment;
  final double currentInvestment;
  final double totalTodaysPnl;
  final double totalPnl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PortfolioCard(
          title: "Total investment",
          value: totalInvestment,
          checkSign: false,
        ),
        const Spacer(),
        PortfolioCard(
          title: "Current value",
          value: currentInvestment,
          checkSign: false,
        ),
        const Spacer(),
        PortfolioCard(
          title: "Today's P&L",
          value: totalTodaysPnl,
          checkSign: true,
        ),
        const Spacer(),
        PortfolioCard(
          title: "Total P&L",
          value: totalPnl,
          checkSign: true,
        ),
      ],
    );
  }
}
