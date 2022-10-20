import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockin/components/stockSearchBar.dart';
import 'package:stockin/global.dart';
import 'package:stockin/size.dart';
import 'package:stockin/theme.dart';

import '../database/data/stocks.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  TextEditingController textEditingController = TextEditingController();

  void searchStock(String text) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getHeight(400),
          child: StockSearchBar(
            searchList: queries,
            searchQueryBuilder: (query, list) {
              return list
                  .where((item) => item
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();
            },
            overlaySearchListItemBuilder: (item) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      (item as Map<String, String>).values.last,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    Text(
                      (item).values.first,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            },
            onItemSelected: (item) {
              setState(() {
                print('$item');
              });
            },
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
        // FaIcon(
        //   Icons.notifications_outlined,
        //   size: getHeight(24),
        //   color: Theme.of(context).primaryColorDark,
        // ),
        // SizedBox(
        //   width: getHeight(20),
        // ),
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
    );
  }
}
