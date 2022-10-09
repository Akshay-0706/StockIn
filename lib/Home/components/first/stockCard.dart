import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size.dart';

class StockCard extends StatelessWidget {
  const StockCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        width: getHeight(250),
        height: getHeight(120),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getHeight(20), horizontal: getHeight(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      FontAwesomeIcons.google,
                      size: getHeight(20),
                      color: Theme.of(context).primaryColorDark,
                    )),
                  ),
                  SizedBox(
                    width: getHeight(20),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AAPL",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: getHeight(18),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Apple",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: getHeight(14),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const FaIcon(Icons.more_vert_rounded)
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    "Volume:",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: getHeight(14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: getHeight(10),
                  ),
                  Text(
                    "\$10,390,00",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: getHeight(14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
