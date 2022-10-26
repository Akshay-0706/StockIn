import 'package:flutter/material.dart';

import '../../../size.dart';

class SummaryColumn extends StatelessWidget {
  const SummaryColumn({
    Key? key,
    required this.title,
    required this.price,
  }) : super(key: key);
  final String title, price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
            fontSize: getHeight(12),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getHeight(10)),
        Text(
          price,
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(14),
            fontWeight: FontWeight.w700,
          ),
        ),
        if (title != "PREV CLOSE" && title != "LOW" && title != "52WK LOW")
          SizedBox(height: getHeight(20)),
      ],
    );
  }
}
