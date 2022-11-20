import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/database/server/api.dart';
import 'package:stockin/database/server/popular.dart';
import 'package:stockin/home/components/popular_card_shimmer.dart';

import '../../../size.dart';
import 'popular_card.dart';

class PopularWeek extends StatefulWidget {
  PopularWeek({
    Key? key,
    required this.changeTab,
    required this.trend,
  }) : super(key: key);
  final Function changeTab;
  final String trend;

  @override
  State<PopularWeek> createState() => _PopularWeekState();
}

class _PopularWeekState extends State<PopularWeek> {
  // final List<Map<String, String>> popularWeek = [
  bool isTrendReady = false;
  late List<PopularTrend> popular;

  @override
  void initState() {
    fetchPopular(widget.trend).then((value) {
      popular = value.popular;
      setState(() {
        isTrendReady = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.trend == "Gainer")
          Text(
            "Most popular week",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: getHeight(26),
              fontWeight: FontWeight.w700,
            ),
          ),
        SizedBox(height: getHeight(10)),
        Text(
          "Top ${widget.trend}s",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(18),
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
            child: Row(
              children: [
                ...List.generate(
                  isTrendReady ? popular.length : 10,
                  (index) => isTrendReady
                      ? PopularCard(
                          index: index,
                          length: popular.length,
                          code: popular[index].code,
                          name: popular[index].name,
                          value: popular[index].value,
                          perChg: popular[index].perChg,
                          changeTab: widget.changeTab,
                        )
                      : PopularCardShimmer(index: index),
                )
              ],
            ),
            // child: SizedBox(
            //   width: getHeight(130) * popular.length +
            //       getHeight(20.05) * (popular.length - 1),
            //   height: getHeight(145),
            //   child: ListView.separated(
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) => PopularCard(
            //             code: popular[index].code,
            //             name: popular[index].name,
            //             value: popular[index].value,
            //             perChg: popular[index].perChg,
            //             changeTab: widget.changeTab,
            //           ),
            //       separatorBuilder: (context, index) =>
            //           SizedBox(width: getHeight(20)),
            //       itemCount: popular.length),
            // ),
          ),
        ),
      ],
    );
  }
}
