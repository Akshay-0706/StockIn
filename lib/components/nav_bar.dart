import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:stockin/components/stock_search_bar.dart';
import 'package:stockin/global.dart';
import 'package:stockin/size.dart';

import '../database/data/stocks.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key, required this.changeTab}) : super(key: key);
  final Function changeTab;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getWidth(150),
          child: StockSearchBar(
            searchList: stocks,
            hintText: "Search for Stocks",
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
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    Text(
                      (item).values.first,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            },
            onItemSelected: (item) => widget.changeTab(3, true,
                (item as Map<String, String>).values.last, (item).values.first),
          ),
        ),
        const Spacer(),
        AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            ...List.generate(
              GlobalParams.navBarQuotes.length,
              (index) => TypewriterAnimatedText(
                GlobalParams.navBarQuotes[index],
                cursor: "",
                speed: const Duration(milliseconds: 50),
                textStyle: TextStyle(
                  fontSize: getHeight(18),
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            )
          ],
        ),
        // Text(
        //   "StockIn",
        //   style: TextStyle(
        //     fontSize: getHeight(18),
        //     color: Theme.of(context).primaryColorDark,
        //   ),
        // ),
        // SizedBox(
        //   width: getHeight(18),
        // ),
        // MouseRegion(
        //   cursor: SystemMouseCursors.click,
        //   child: GestureDetector(
        //     onTap: () => themeChanger.changeTheme(),
        //     child: FaIcon(
        //       themeChanger.isDarkMode() ? FontAwesomeIcons.moon : Icons.sunny,
        //       size: getHeight(18),
        //       color: Theme.of(context).primaryColorDark,
        //     ),
        //   ),
        // )

        // FaIcon(
        //   Icons.notifications_outlined,
        //   size: getHeight(24),
        //   color: Theme.of(context).primaryColorDark,
        // ),
        // SizedBox(
        //   width: getHeight(20),
        // ),
        // Row(
        //   children: [
        //     // FaIcon(
        //     //   Icons.person,
        //     //   size: getHeight(24),
        //     //   color: Theme.of(context).primaryColorDark,
        //     // ),
        //     // SizedBox(
        //     //   width: getHeight(10),
        //     // ),
        //     Text(
        //       "Akshay Vhatkar",
        //       style: TextStyle(
        //           color: Theme.of(context).primaryColorDark,
        //           fontSize: getHeight(14)),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
