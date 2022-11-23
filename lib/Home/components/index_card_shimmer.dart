import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../size.dart';

class IndexCardShimmer extends StatelessWidget {
  const IndexCardShimmer({
    Key? key,
    required this.index,
    required this.length,
    required this.gradient,
  }) : super(key: key);
  final int index, length;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    const Color baseColor = Colors.black;
    final Color highlightColor = Theme.of(context).primaryColorDark;

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: getHeight(20)),
          child: Container(
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
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: getHeight(40),
                          height: getHeight(40),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withAlpha(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getHeight(20),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: getHeight(60),
                              height: getHeight(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.black.withAlpha(20),
                              ),
                            ),
                          ),
                          SizedBox(height: getHeight(10)),
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: getHeight(40),
                              height: getHeight(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.black.withAlpha(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      height: getHeight(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black.withAlpha(20),
                      ),
                    ),
                  ),
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
