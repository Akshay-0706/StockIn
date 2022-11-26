import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/database/server/api.dart';
import 'package:stockin/database/server/popular.dart';
import 'package:stockin/home/components/popular_card_shimmer.dart';

import '../../../size.dart';
import 'popular_card.dart';

class PopularWeek extends StatefulWidget {
  const PopularWeek({
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
  bool isTrendReady = false;
  late List<PopularTrend> popular;
  late Color? color;
  late List<double> trend = [];

  late Timer timer;

  void getPopular() {
    fetchPopular(widget.trend).then((value) {
      if (value != null) {
        popular = value.popular;
        if (mounted) {
          setState(() {
            isTrendReady = true;
          });
        }
      }
    });
  }

  @override
  void initState() {
    getPopular();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => getPopular());
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
                ...List.generate(isTrendReady ? popular.length : 10, (index) {
                  if (isTrendReady) {
                    color = trend.length != popular.length
                        ? null
                        : trend[index] == popular[index].value
                            ? null
                            : popular[index].value > trend[index]
                                ? Colors.greenAccent
                                : Colors.redAccent;
                    if (trend.length != popular.length) {
                      trend.add(popular[index].value);
                    }
                    // print(1 -
                    //     (popular[0].perChg.abs() -
                    //         popular[index].perChg.abs()));
                    // trend[index] = popular[index].value;
                    // color = widget.trend == "Gainer"
                    //     ? Colors.green
                    //     : Colors.red;

                    return PopularCard(
                      index: index,
                      length: popular.length,
                      code: popular[index].code,
                      value: popular[index].value,
                      perChg: popular[index].perChg,
                      changeTab: widget.changeTab,
                      color: color,
                    );
                  } else {
                    return PopularCardShimmer(index: index);
                  }
                })
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
