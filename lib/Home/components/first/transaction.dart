import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size.dart';

class Transaction extends StatelessWidget {
  const Transaction({
    Key? key,
  }) : super(key: key);

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
              child: Transform.rotate(
            angle: -45,
            child: FaIcon(
              FontAwesomeIcons.arrowUp,
              size: getHeight(20),
              color: Theme.of(context).primaryColorDark,
            ),
          )),
        ),
        SizedBox(width: getHeight(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Buy apple stock",
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(18),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "stock investment",
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: getHeight(14),
              ),
            ),
          ],
        ),
        const Spacer(),
        RichText(
          text: TextSpan(
              text: "Interest rate",
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getHeight(16),
                  fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: " 2%",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(16),
                  ),
                )
              ]),
        ),
        const Spacer(),
        Text(
          "\$20,56,76",
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: getHeight(18),
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
