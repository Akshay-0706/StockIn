import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size.dart';

class IndexCard extends StatelessWidget {
  const IndexCard({
    Key? key,
    required this.code,
    required this.name,
    required this.gradient,
  }) : super(key: key);
  final String code, name;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getHeight(220),
      height: getHeight(120),
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColorLight.withAlpha(10),
        gradient: gradient,
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
                    color: Colors.black.withAlpha(20),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.google,
                      size: getHeight(20),
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: getHeight(20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      code,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: getHeight(18),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: getHeight(14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  "Volume:",
                  style: TextStyle(
                    color: Colors.black,
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
                    color: Colors.black,
                    fontSize: getHeight(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
