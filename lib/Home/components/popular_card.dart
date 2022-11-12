import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({
    Key? key,
    required this.code,
    required this.name, required this.changeTab,
  }) : super(key: key);
  final String code, name;
  final Function changeTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => changeTab(3, true, code, name),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: getHeight(130),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(getHeight(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                      FontAwesomeIcons.apple,
                      size: getHeight(25),
                      color: Theme.of(context).primaryColorDark,
                    )),
                  ),
                  SizedBox(width: getHeight(10)),
                  Text(
                    code,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: getHeight(12),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: getHeight(10)),
              Text(
                name,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getHeight(10),
                ),
              ),
              SizedBox(height: getHeight(7)),
              Text(
                "\$1200",
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(16),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: getHeight(7)),
              RichText(
                text: TextSpan(
                    text: "20%",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: getHeight(10),
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: " this week",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: getHeight(10),
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
