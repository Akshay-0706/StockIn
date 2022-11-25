import 'package:flutter/material.dart';

import '../../../size.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({
    Key? key,
    required this.index,
    required this.length,
    required this.code,
    required this.changeTab,
    required this.value,
    required this.perChg,
    required this.color,
  }) : super(key: key);
  final int index, length;
  final String code;
  final double value, perChg;
  final Function changeTab;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          // onTap: () => changeTab(2, true, code, name),
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            width: getHeight(150),
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(getHeight(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Container(
                  //       width: getHeight(40),
                  //       height: getHeight(40),
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color:
                  //             Theme.of(context).primaryColorLight.withAlpha(20),
                  //       ),
                  //       child: Center(
                  //           child: Text(
                  //         code[0],
                  //         style: TextStyle(
                  //             color: Theme.of(context).primaryColorDark,
                  //             fontSize: getHeight(18),
                  //             fontWeight: FontWeight.bold),
                  //       )),
                  //     ),
                  //     SizedBox(width: getHeight(10)),
                  //     Text(
                  //       code,
                  //       style: TextStyle(
                  //           color: Theme.of(context).primaryColorDark,
                  //           fontSize: getHeight(14),
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(width: getHeight(7)),
                  Text(
                    code,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: getHeight(14),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: getHeight(7)),
                  Divider(
                      color: Theme.of(context).primaryColorDark.withAlpha(40)),
                  // SizedBox(
                  //   width: getHeight(100),
                  //   child: Text(
                  //     name,
                  //     style: TextStyle(
                  //       color: Theme.of(context).primaryColorLight,
                  //       fontSize: getHeight(10),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: getHeight(7)),
                  Text(
                    value.toStringAsFixed(2),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: getHeight(20),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: getHeight(7)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (value * perChg / 100).toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: color ?? Theme.of(context).primaryColorDark,
                          fontSize: getHeight(14),
                        ),
                      ),
                      Text(
                        "$perChg%",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: color ?? Theme.of(context).primaryColorDark,
                          fontSize: getHeight(14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight(7)),

                  // RichText(
                  //   text: TextSpan(
                  //       text: "$perChg%",
                  //       style: TextStyle(
                  //         color: Theme.of(context).primaryColorDark,
                  //         fontSize: getHeight(10),
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //       children: [
                  //         TextSpan(
                  //           text: "",
                  //           style: TextStyle(
                  //             color: Theme.of(context).primaryColorLight,
                  //             fontSize: getHeight(10),
                  //           ),
                  //         )
                  //       ]),
                  // ),
                ],
              ),
            ),
          ),
        ),
        if (index != length - 1) SizedBox(width: getHeight(20)),
      ],
    );
  }
}
