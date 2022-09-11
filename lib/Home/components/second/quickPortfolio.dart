import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size.dart';

class QuickPortfolio extends StatelessWidget {
  const QuickPortfolio({
    Key? key,
    required this.moreInfo,
    required this.title,
    required this.price,
    required this.iconData,
  }) : super(key: key);
  final bool moreInfo;
  final String title, price;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: getHeight(40),
          height: getHeight(40),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColorLight.withAlpha(20),
          ),
          child: Center(
              child: FaIcon(
            iconData,
            size: getHeight(20),
          )),
        ),
        SizedBox(width: getHeight(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getHeight(14)),
            ),
            Text(
              price,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getHeight(14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        if (moreInfo) const Spacer(),
        if (moreInfo) const FaIcon(Icons.more_horiz_rounded)
      ],
    );
  }
}
