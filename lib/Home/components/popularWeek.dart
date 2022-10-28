import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';
import 'popularCard.dart';

class PopularWeek extends StatelessWidget {
  PopularWeek({
    Key? key, required this.changeTab,
  }) : super(key: key);
  final Function changeTab;


  final List<Map<String, String>> popularWeek = [
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
    {"code": "SBIN.NS", "name": "State Bank of India"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Most popular week",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: getHeight(26),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getHeight(20)),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: getHeight(130) * popularWeek.length +
                  getHeight(20.05) * (popularWeek.length - 1),
              height: getHeight(145),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => PopularCard(
                      code: popularWeek[index].entries.first.value,
                      name: popularWeek[index].entries.last.value, changeTab: changeTab,),
                  separatorBuilder: (context, index) =>
                      SizedBox(width: getHeight(20)),
                  itemCount: popularWeek.length),
            ),
          ),
        ),
      ],
    );
  }
}
