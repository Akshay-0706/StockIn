import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../size.dart';

class PopularCardShimmer extends StatelessWidget {
  const PopularCardShimmer({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Theme.of(context).primaryColorLight;
    final Color highlightColor = Theme.of(context).primaryColorDark;
    return Row(
      children: [
        Container(
          width: getHeight(150),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(getHeight(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer.fromColors(
                //   baseColor: baseColor,
                //   highlightColor: highlightColor,
                //   child: Container(
                //     width: getHeight(40),
                //     height: getHeight(40),
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color:
                //           Theme.of(context).primaryColorLight.withAlpha(20),
                //     ),
                //   ),
                // ),
                SizedBox(width: getHeight(7)),
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: getHeight(50),
                    height: getHeight(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight.withAlpha(20),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                // Shimmer.fromColors(
                //   baseColor: baseColor,
                //   highlightColor: highlightColor,
                //   child: Container(
                //     width: getHeight(100),
                //     height: getHeight(10),
                //     decoration: BoxDecoration(
                //       color: Theme.of(context).primaryColorLight.withAlpha(20),
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //   ),
                // ),
                SizedBox(height: getHeight(7)),
                Divider(
                    color: Theme.of(context).primaryColorDark.withAlpha(40)),
                SizedBox(height: getHeight(7)),
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: getHeight(70),
                    height: getHeight(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight.withAlpha(20),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Container(
                        width: getHeight(40),
                        height: getHeight(14),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColorLight.withAlpha(20),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Container(
                        width: getHeight(40),
                        height: getHeight(14),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColorLight.withAlpha(20),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getHeight(7)),
              ],
            ),
          ),
        ),
        if (index != 9) SizedBox(width: getHeight(20)),
      ],
    );
  }
}
