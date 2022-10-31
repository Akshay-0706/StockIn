

import 'package:flutter/material.dart';

import '../../size.dart';

class WatchlistBody extends StatelessWidget {
  const WatchlistBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Watchlist",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: getHeight(32),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
