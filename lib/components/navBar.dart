import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockin/size.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getHeight(40)),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColorLight,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: getWidth(120),
                  height: getHeight(40),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(4)),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: getHeight(14),
                          color: Theme.of(context).primaryColorDark,
                        ),
                        cursorColor: Theme.of(context).primaryColorDark,
                        cursorRadius: const Radius.circular(8),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search for Stock Market",
                            hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                            )),
                      ),
                    ),
                  ),
                ),
                FaIcon(
                  Icons.search,
                  color: Theme.of(context).primaryColorDark,
                ),
                SizedBox(width: getHeight(10)),
              ],
            ),
          ),
          const Spacer(),
          Text(
            "Saturday, 10 September, 2022",
            style: TextStyle(
              fontSize: getHeight(14),
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          SizedBox(
            width: getHeight(20),
          ),
          FaIcon(
            Icons.notifications_outlined,
            size: getHeight(24),
            color: Theme.of(context).primaryColorDark,
          ),
          SizedBox(
            width: getHeight(20),
          ),
          Row(
            children: [
              FaIcon(
                Icons.person,
                size: getHeight(24),
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                width: getHeight(10),
              ),
              Text(
                "Akshay Vhatkar",
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(14)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
