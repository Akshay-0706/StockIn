import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size.dart';

class MMIInfoCards extends StatelessWidget {
  const MMIInfoCards({
    Key? key,
    required this.borderColor,
    required this.iconName,
    required this.zoneName,
    required this.zoneInfo,
  }) : super(key: key);
  final Color borderColor;
  final String iconName, zoneName, zoneInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 130,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getHeight(10)),
                  Row(
                    children: [
                      SvgPicture.asset("assets/design/$iconName.svg"),
                      SizedBox(width: getHeight(10)),
                      Text(zoneName)
                    ],
                  ),
                  SizedBox(height: getHeight(20)),
                  Text(zoneInfo),
                  SizedBox(height: getHeight(10)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
