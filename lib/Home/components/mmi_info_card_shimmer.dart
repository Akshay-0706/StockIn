import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../size.dart';

class MMIInfoCardsShimmer extends StatelessWidget {
  const MMIInfoCardsShimmer({
    Key? key,
    required this.borderColor,
    required this.iconName,
  }) : super(key: key);
  final Color borderColor;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Theme.of(context).primaryColorLight;
    final Color highlightColor = Theme.of(context).primaryColorDark;
    return Container(
      width: 270,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
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
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: getHeight(100),
                          height: getHeight(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColorLight
                                .withAlpha(20),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight(20)),
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      height: getHeight(60),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).primaryColorLight.withAlpha(20),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
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
