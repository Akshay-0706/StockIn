import 'dart:async';

import 'package:candlesticks/candlesticks.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockin/components/appDrawer.dart';
import 'package:stockin/database/stock/api.dart';

import '../../database/stock/chart.dart';
import '../../size.dart';

class StockBody extends StatefulWidget {
  const StockBody({Key? key}) : super(key: key);
  final String symbol = "GOOG";

  @override
  State<StockBody> createState() => _StockBodyState();
}

class _StockBodyState extends State<StockBody> {
  late Future<Chart> futureStock;
  late Timer timer;
  late double regularMarketPrice = 0;
  String selectedRange = "1d", selectedInterval = "1m";
  late List<String> ranges = [];

  void callStock() async {
    setState(() {
      futureStock = fetchStock(widget.symbol, selectedRange, selectedInterval);
    });
  }

  @override
  void initState() {
    futureStock = fetchStock(widget.symbol, "1d", "1m");

    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => callStock());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AppDrawer(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(getHeight(20)),
            child: SizedBox(
              height: SizeConfig.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: FaIcon(
                            Icons.arrow_back_ios_rounded,
                            size: getHeight(25),
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                      SizedBox(width: getHeight(20)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.symbol,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: getHeight(26),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: getHeight(10)),
                            FutureBuilder<Chart>(
                              future: futureStock,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const LinearProgressIndicator();
                                }
                                ranges = List<String>.generate(
                                    snapshot.data!.validRanges.length,
                                    (index) =>
                                        snapshot.data!.validRanges[index]);
                                return setRegularMarketPrice(snapshot);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "Chart",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: getHeight(26),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: getHeight(20)),
                  FutureBuilder<Chart>(
                    future: futureStock,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const LinearProgressIndicator();
                      }
                      return rangeCreater(FontAwesomeIcons.calendar,
                          "Data range", true, ranges);
                    },
                  ),
                  SizedBox(height: getHeight(20)),
                  FutureBuilder<Chart>(
                    future: futureStock,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const LinearProgressIndicator();
                      }
                      return rangeCreater(FontAwesomeIcons.clock,
                          "Time interval", false, Chart.interval);
                    },
                  ),
                  SizedBox(height: getHeight(20)),
                  FutureBuilder<Chart>(
                    future: futureStock,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const LinearProgressIndicator();
                      }
                      return chartCreater(snapshot);
                    },
                  ),
                  SizedBox(height: getHeight(10)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget chartCreater(AsyncSnapshot<Chart> snapshot) {
    return Container(
      height: getHeight(SizeConfig.height * 0.5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: candleStickCreater(
            snapshot.data!.timestamp,
            snapshot.data!.open,
            snapshot.data!.close,
            snapshot.data!.high,
            snapshot.data!.low,
            snapshot.data!.volume),
      ),
    );
  }

  Candlesticks candleStickCreater(
      List<dynamic> timestamp,
      List<dynamic> open,
      List<dynamic> close,
      List<dynamic> high,
      List<dynamic> low,
      List<dynamic> volume) {
    late List<double> newOpen, newClose, newHigh, newLow, newVolume;
    late List<DateTime> newTimestamp;

    double getPreviousFinite(int index, List<dynamic> list) {
      while (list[index--] == null) {
        if (index == 0) break;
      }
      return double.parse(list[index].toString());
    }

    newTimestamp = List<DateTime>.generate(timestamp.length, (index) {
      return timestamp[index] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(timestamp[index] * 1000);
    });
    newOpen = List<double>.generate(open.length, (index) {
      return open[index] == null
          ? getPreviousFinite(index, open)
          : double.parse(open[index].toString());
    });
    newClose = List<double>.generate(close.length, (index) {
      return close[index] == null
          ? getPreviousFinite(index, close)
          : double.parse(close[index].toString());
    });
    newHigh = List<double>.generate(close.length, (index) {
      return close[index] == null
          ? getPreviousFinite(index, high)
          : double.parse(close[index].toString());
    });
    newLow = List<double>.generate(close.length, (index) {
      return low[index] == null
          ? getPreviousFinite(index, low)
          : double.parse(low[index].toString());
    });
    newVolume = List<double>.generate(volume.length, (index) {
      return volume[index] == null
          ? getPreviousFinite(index, volume)
          : double.parse(volume[index].toString());
    });

    return Candlesticks(
        candles: List<Candle>.generate(
            newTimestamp.length,
            (index) => Candle(
                date: newTimestamp[index],
                high: newHigh[index],
                low: newLow[index],
                open: newOpen[index],
                close: newClose[index],
                volume: newVolume[index])));
  }

  Widget setRegularMarketPrice(AsyncSnapshot<Chart> snapshot) {
    var current = snapshot.data!.regularMarketPrice;
    var previousClose = snapshot.data!.chartPreviousClose;
    Color color = Theme.of(context).primaryColorDark;

    if (current > regularMarketPrice) {
      color = Colors.greenAccent;
    } else if (current < regularMarketPrice) {
      color = Colors.redAccent;
    }
    regularMarketPrice = snapshot.data!.regularMarketPrice;
    return Text(
      "$current ${(current - previousClose).toStringAsFixed(2)} ${(100 - previousClose / current * 100).toStringAsFixed(2)}%",
      style: TextStyle(
          color: color, fontSize: getHeight(16), fontWeight: FontWeight.bold),
    );
  }

  Widget rangeCreater(IconData iconData, String title, bool forRange,
      List<String> validRanges) {
    return Row(
      children: [
        FaIcon(iconData),
        SizedBox(
          width: getHeight(10),
        ),
        Text(
          "$title:    ",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: getHeight(14),
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomDropdownButton2(
            hint: forRange ? selectedRange : selectedInterval,
            value: forRange ? selectedRange : selectedInterval,
            dropdownItems: validRanges,
            iconEnabledColor: Theme.of(context).primaryColorDark,
            buttonDecoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColorDark),
                borderRadius: BorderRadius.circular(8)),
            icon: const FaIcon(Icons.arrow_drop_down_rounded),
            iconSize: getHeight(20),
            onChanged: (value) {
              setState(() {
                if (forRange) {
                  selectedRange = value!;
                } else {
                  selectedInterval = value!;
                }
                callStock();
              });
            })
        // ...List.generate(validRanges.length, (index) {
        //   return Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: InkWell(
        //       onTap: () {
        //         setState(() {
        //           if (index != selectedRange) selectedRange = index;
        //           callStock();
        //         });
        //       },
        //       borderRadius: BorderRadius.circular(8),
        //       child: Ink(
        //           width: getHeight(40),
        //           height: getHeight(25),
        //           decoration: BoxDecoration(
        //               color: index == selectedRange
        //                   ? Theme.of(context).primaryColorDark
        //                   : Theme.of(context)
        //                       .primaryColorLight
        //                       .withOpacity(0.05),
        //               borderRadius: BorderRadius.circular(8)),
        //           child: Center(
        //               child: Text(
        //             validRanges[index],
        //             style: TextStyle(
        //               color: index == selectedRange
        //                   ? Colors.white
        //                   : Theme.of(context).primaryColorDark,
        //               fontSize: getHeight(14),
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ))),
        //     ),
        //   );
        // })
      ],
    );
  }
}

// class CandleStickPainter extends CustomPainter {
//   CandleStickPainter(
//       {required this.open,
//       required this.close,
//       required this.high,
//       required this.low})
//       : wickPaint = Paint()..color = Colors.black,
//         gainPaint = Paint()..color = Colors.green,
//         lossPaint = Paint()..color = Colors.red;

//   final List<dynamic> open, close, high, low;
//   late List<double> newOpen, newClose, newHigh, newLow;

//   late double lowest, highest;

//   final Paint wickPaint, gainPaint, lossPaint;
//   final double wickWidth = 1.0, candleWidth = 3.0;

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Generate candlesticks
//     List<CandleStick> candleSticks = generateCandleSticks(size);

//     // Paint candlesticks
//     for (CandleStick candleStick in candleSticks) {
//       // Paint wick
//       print(size.height.toString() + " " + candleStick.wickHighY.toString());
//       canvas.drawRect(
//           Rect.fromLTRB(
//               candleStick.centerX - (wickWidth / 2),
//               size.height - candleStick.wickHighY,
//               candleStick.centerX + (wickWidth / 2),
//               size.height - candleStick.wickLowY),
//           wickPaint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

//   List<CandleStick> generateCandleSticks(Size size) {
//     newOpen = List<double>.generate(open.length, (index) {
//       return open[index] == null ? 0 : double.parse(open[index].toString());
//     });
//     newClose = List<double>.generate(close.length, (index) {
//       return close[index] == null ? 0 : double.parse(close[index].toString());
//     });
//     newHigh = List<double>.generate(close.length, (index) {
//       return close[index] == null ? 0 : double.parse(close[index].toString());
//     });
//     newLow = List<double>.generate(close.length, (index) {
//       return low[index] == null ? 0 : double.parse(low[index].toString());
//     });

//     lowest = getLowest(newLow);
//     highest = getHighest(newHigh);

//     print(highest);
//     print(lowest);

//     final pixelsPerWindow = size.width / (newOpen.length + 1);

//     final pixelsPerDollar = size.height / (highest - lowest);

//     print(pixelsPerDollar);

//     final List<CandleStick> candleSticks = [];

//     for (int i = 0; i < newOpen.length; i++) {
//       candleSticks.add(CandleStick(
//           centerX: (i + 1) * pixelsPerWindow,
//           wickHighY: (newHigh[i] - lowest) * (pixelsPerDollar * 0.5),
//           wickLowY: (newLow[i] - lowest) * pixelsPerDollar,
//           candleHighY: (newOpen[i] - lowest) * pixelsPerDollar,
//           candleLowY: (newClose[i] - lowest) * pixelsPerDollar,
//           candlePaint: isGain(i) ? gainPaint : lossPaint));
//     }

//     return candleSticks;
//   }

//   getHighest(List<double> newHigh) {
//     List<double> tempHigh =
//         List<double>.generate(newHigh.length, (index) => newHigh[index]);

//     tempHigh.sort();
//     return tempHigh[tempHigh.length - 1];
//   }

//   getLowest(List<double> newLow) {
//     List<double> tempLow =
//         List<double>.generate(newLow.length, (index) => newLow[index]);

//     tempLow.sort();
//     return tempLow[0];
//   }

//   bool isGain(int i) {
//     if (i == 0) {
//       return true;
//     } else {
//       return newOpen[i] > newOpen[i - 1];
//     }
//   }
// }

// class CandleStick {
//   final double centerX;
//   final double wickHighY;
//   final double wickLowY;
//   final double candleHighY;
//   final double candleLowY;
//   final Paint candlePaint;

//   CandleStick(
//       {required this.centerX,
//       required this.wickHighY,
//       required this.wickLowY,
//       required this.candleHighY,
//       required this.candleLowY,
//       required this.candlePaint});
// }
