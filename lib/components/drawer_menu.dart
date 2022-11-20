import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../global.dart';
import '../size.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.tap,
    required this.isSelected,
    required this.shrink,
  }) : super(key: key);
  final String iconPath, title;
  final bool isSelected, shrink;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: InkWell(
            onTap: tap,
            hoverColor: isSelected ? null : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(4),
            child: AnimatedContainer(
              duration: GlobalParams.duration,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
                    : null,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: shrink
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  mainAxisSize: shrink ? MainAxisSize.min : MainAxisSize.max,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/drawer/$iconPath.svg",
                      width: getHeight(18),
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context)
                              .primaryColorLight
                              .withOpacity(0.7),
                    ),
                    if (!shrink) SizedBox(width: getHeight(10)),
                    if (!shrink)
                      Text(
                        title,
                        style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Theme.of(context)
                                  .primaryColorLight
                                  .withOpacity(0.7),
                          fontSize: getHeight(14),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: getHeight(10)),
      ],
    );
  }
}
