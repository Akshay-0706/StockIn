import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/size.dart';

import '../../database/server/api.dart';
import '../../database/server/indices.dart';

class IndicesBody extends StatefulWidget {
  const IndicesBody({super.key});

  @override
  State<IndicesBody> createState() => _IndicesBodyState();
}

class _IndicesBodyState extends State<IndicesBody>
    with SingleTickerProviderStateMixin {
  late Indices allIndices;
  late Timer timer;
  Color positive = const Color(0xff00a25b), negative = const Color(0xfffc5a5a);
  String mode = "nse";
  late TabController tabController;
  bool areIndicesReady = false;

  // final selectedColor = Theme.of(context).primaryColorDark;
  final unselectedColor = const Color(0xff5f6368);
  final tabs = [
    const Tab(text: 'NSE'),
    const Tab(text: 'BSE'),
  ];

  Map<int, int> cardWidth = {
    300: 1,
    400: 2,
    600: 3,
    800: 4,
    1000: 5,
    1200: 6,
    1400: 7,
    1600: 8,
    1800: 9,
    2000: 10,
  };

  void callStock() async {
    fetchIndices(mode).then((value) {
      if (value != null) {
        setState(() {
          allIndices = value;
        });
      }
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    fetchIndices(mode).then((value) {
      if (value != null) {
        allIndices = value;
        setState(() {
          areIndicesReady = true;
        });
      }
    });

    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => callStock());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    tabController.dispose();
  }

  int getCardNumbers() {
    int width = SizeConfig.width.toInt();
    int value = 12;
    for (var entry in cardWidth.entries) {
      if (entry.key >= width) {
        value = entry.value;
        break;
      }
    }
    return value;
  }

  // double getAspectRatio() {
  //   int width = SizeConfig.width.toInt();
  //   int height = SizeConfig.height.toInt();
  //   double value = 1;
  //   // if(width <= 200)
  //   // value =
  //   return value;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: getHeight(10)),
                Text(
                  "Indices",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: getHeight(22)),
                ),
              ],
            ),
            SizedBox(height: getHeight(10)),
            Container(
              width: getHeight(400),
              height: getHeight(50),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TabBar(
                onTap: (value) {
                  mode = value == 0 ? "nse" : "bse";
                  // futureIndices = fetchIndices(mode);
                  // callStock();
                },
                controller: tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).primaryColor,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1CA7EC), Color(0xFF1F2F98)],
                  ),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: tabs,
              ),
            ),
            SizedBox(height: getHeight(20)),
            if (!areIndicesReady)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
                child: LinearProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            if (areIndicesReady)
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse
                  },
                ),
                child: SizedBox(
                  height: SizeConfig.height * 0.85,
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: allIndices.indices.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: getCardNumbers(),
                      ),
                      itemBuilder: (context, index) {
                        String indexValue = allIndices
                            .indices[index].index.entries
                            .elementAt(mode == "nse" ? 1 : 0)
                            .value;
                        double last = double.parse(allIndices
                            .indices[index].index.entries
                            .elementAt(mode == "nse" ? 3 : 1)
                            .value
                            .toString());
                        double variation = double.parse(allIndices
                            .indices[index].index.entries
                            .elementAt(mode == "nse" ? 4 : 2)
                            .value
                            .toString());
                        double percentageChange = double.parse(allIndices
                            .indices[index].index.entries
                            .elementAt(mode == "nse" ? 5 : 3)
                            .value
                            .toString());

                        late Color color;
                        if (percentageChange >= 1) {
                          color = positive;
                        } else if (percentageChange <= -1) {
                          color = negative;
                        } else {
                          if (percentageChange >= 0) {
                            color = positive.withOpacity(percentageChange);
                          } else {
                            color = negative.withOpacity(percentageChange * -1);
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.withOpacity(
                              //         opacity > 0.5 ? 0.5 : opacity),
                              //     spreadRadius: 5,
                              //     blurRadius: 7,
                              //     offset: Offset(2, 4),
                              //   )
                              // ],
                              //border: Border.all(color: Theme.of(context).primaryColorDark)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: getHeight(50),
                                    child: Text(
                                      indexValue,
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontSize: getHeight(12),
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                    ),
                                  ),
                                  // const Spacer(),
                                  Text(
                                    last.toString(),
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                  // const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        variation.toString(),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                      ),
                                      Text(
                                        "$percentageChange%",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            SizedBox(height: getHeight(20))
          ],
        ),
      ),
    );
  }
}
