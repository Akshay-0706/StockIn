import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size.dart';

class IndexCard extends StatelessWidget {
  const IndexCard({
    Key? key,
    required this.id,
    required this.name,
    required this.volume,
    required this.change,
    required this.gradient,
    required this.color,
    required this.index,
    required this.length,
  }) : super(key: key);
  final int index, length;
  final String id, name, volume, change;
  final Gradient gradient;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: getHeight(20)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: getHeight(220),
            height: getHeight(120),
            decoration: BoxDecoration(
              // color: Theme.of(context).primaryColorDark.withAlpha(200),
              gradient: gradient,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                if (color != null)
                  BoxShadow(color: color!, blurRadius: 10, spreadRadius: 5),
              ],
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
                            child: Text(
                          id,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getHeight(16),
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      SizedBox(width: getHeight(20)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: getHeight(18),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "$change%",
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
                        "Value:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getHeight(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: getHeight(10)),
                      Text(
                        volume,
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
          ),
        ),
        if (index < length - 1) SizedBox(width: getHeight(20)),
      ],
    );
  }
}
