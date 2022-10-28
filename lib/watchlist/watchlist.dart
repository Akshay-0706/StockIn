import 'package:flutter/material.dart';
import 'package:stockin/watchlist/components/body.dart';

class Watchlist extends StatelessWidget {
  const Watchlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WatchlistBody(),
    );
  }
}
