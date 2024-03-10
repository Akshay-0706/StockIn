import 'dart:async';

import 'package:candlesticks/candlesticks.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockin/database/server/api.dart';

import '../../database/server/chart.dart';
import '../../size.dart';

class StockBody extends StatefulWidget {
  const StockBody({Key? key, required this.code, required this.name})
      : super(key: key);
  final String code, name;

  @override
  State<StockBody> createState() => _StockBodyState();
}

class _StockBodyState extends State<StockBody> {
  late Chart futureStock;
  late Timer timer;
  late double regularMarketPrice = 0;
  String selectedRange = "1d", selectedInterval = "1m";
  late List<String> ranges = [];
  bool stockIsReady = false;

  void callStock() async {
    setState(() {
      fetchChart("${widget.code}.NS", selectedRange, selectedInterval)
          .then((value) {
        if (value != null) {
          futureStock = value;
          ranges = List<String>.generate(futureStock.validRanges.length,
              (index) => futureStock.validRanges[index]);
        }
      });
    });
  }

  @override
  void initState() {
    fetchChart("${widget.code}.NS", "1d", "1m").then((value) {
      if (value != null) {
        futureStock = value;
        ranges = List<String>.generate(futureStock.validRanges.length,
            (index) => futureStock.validRanges[index]);
        setState(() {
          stockIsReady = true;
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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getHeight(20)),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight(20)),
                Text(
                  "${widget.name} (${widget.code}.NS)",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: getHeight(20),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: getHeight(10)),
                if (!stockIsReady) const LinearProgressIndicator(),
                if (stockIsReady) setRegularMarketPrice(futureStock),
              ],
            ),
            SizedBox(height: getHeight(20)),
            const Spacer(),
            if (stockIsReady)
              Text(
                "Chart",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(26),
                  fontWeight: FontWeight.w700,
                ),
              ),
            SizedBox(height: getHeight(20)),
            if (stockIsReady)
              rangeCreater(
                  FontAwesomeIcons.calendar, "Data range", true, ranges),
            SizedBox(height: getHeight(20)),
            if (stockIsReady)
              rangeCreater(FontAwesomeIcons.clock, "Time interval", false,
                  Chart.interval),

            SizedBox(height: getHeight(20)),
            if (stockIsReady) chartCreater(futureStock),
            const Spacer(),

            // SizedBox(height: getHeight(20)),
            // FutureBuilder<Finances>(
            //   future: futureFinances,
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) {
            //       return const LinearProgressIndicator();
            //     }
            //     return Expanded(child: buildExpandableTable());
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget chartCreater(Chart futureStock) {
    return Container(
      width: SizeConfig.width * 0.82,
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
            futureStock.timestamp.reversed.toList(),
            futureStock.open.reversed.toList(),
            futureStock.close.reversed.toList(),
            futureStock.high.reversed.toList(),
            futureStock.low.reversed.toList(),
            futureStock.volume.reversed.toList()),
      ),
    );
  }

  Candlesticks candleStickCreater(
    List<dynamic> timestamp,
    List<dynamic> open,
    List<dynamic> close,
    List<dynamic> high,
    List<dynamic> low,
    List<dynamic> volume,
  ) {
    late List<double> newOpen, newClose, newHigh, newLow, newVolume;
    late List<DateTime> newTimestamp;

    double getPreviousFinite(int index, List<dynamic> list) {
      while (list[index] == null) {
        if (index == 0) break;
        index--;
      }

      if (index == 0 && list[index] == null) {
        while (list[index] == null) {
          if (index == list.length - 1) break;
          index++;
        }
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

  Widget setRegularMarketPrice(Chart futureStock) {
    var current = futureStock.regularMarketPrice;
    var previousClose = futureStock.chartPreviousClose;
    Color color = Theme.of(context).primaryColorDark;
    String sign = "";

    if (current > regularMarketPrice) {
      color = Colors.greenAccent;
    } else if (current < regularMarketPrice) {
      sign = "-";
      color = Colors.redAccent;
    }
    regularMarketPrice = futureStock.regularMarketPrice;
    return Row(
      children: [
        Text(
          "$current",
          style: TextStyle(
              color: color,
              fontSize: getHeight(26),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(width: getHeight(20)),
        Text(
          sign + (current - previousClose).toStringAsFixed(2),
          style: TextStyle(
              color: color,
              fontSize: getHeight(18),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(width: getHeight(10)),
        Text(
          "($sign${(100 - previousClose / current * 100).toStringAsFixed(2)}%)",
          style: TextStyle(
              color: color,
              fontSize: getHeight(18),
              fontWeight: FontWeight.bold),
        ),
      ],
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
      ],
    );
  }
}

const Color primaryColor = Color(0xFF1e2f36); //corner
const Color accentColor = Color(0xFF0d2026); //background
const TextStyle textStyle = TextStyle(color: Colors.white);
const TextStyle textStyleSubItems = TextStyle(color: Colors.grey);

ExpandableTable buildExpandableTable() {
  const int col = 6;
  // const int subCol = 5;
  const int row = 6;

  //Creation header
  // ExpandableTableHeader subHeader = ExpandableTableHeader(
  //     firstCell: Container(
  //         color: primaryColor,
  //         margin: const EdgeInsets.all(1),
  //         child: const Center(
  //             child: Text(
  //           'Expandable Column',
  //           style: textStyleSubItems,
  //         ))),
  //     children: List.generate(
  //         SUB_COLUMN_COUNT,
  //         (index) => Container(
  //             color: primaryColor,
  //             margin: const EdgeInsets.all(1),
  //             child: Center(
  //                 child: Text(
  //               'Sub Column $index',
  //               style: textStyleSubItems,
  //             )))));

  //Creation header
  ExpandableTableHeader header = ExpandableTableHeader(
      firstCell: Container(
          color: primaryColor,
          margin: const EdgeInsets.all(1),
          child: const Center(
              child: Text(
            'Breakdown',
            style: textStyle,
          ))),
      children: List.generate(
          col - 1,
          (index) => Container(
              color: primaryColor,
              margin: const EdgeInsets.all(1),
              child: Center(
                  child: Text(
                'Column $index',
                style: textStyle,
              )))));

  //Creation sub rows
  // List<ExpandableTableRow> subTows1 = List.generate(
  //     row,
  //     (rowIndex) => ExpandableTableRow(
  //           height: 10,
  //           firstCell: Container(
  //               color: primaryColor,
  //               margin: const EdgeInsets.all(1),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 16.0),
  //                 child: Text(
  //                   'Sub Sub Row $rowIndex',
  //                   style: textStyleSubItems,
  //                 ),
  //               )),
  //           children: List<Widget>.generate(
  //               col - 1,
  //               (columnIndex) => Container(
  //                   color: primaryColor,
  //                   margin: const EdgeInsets.all(1),
  //                   child: Center(
  //                       child: Text(
  //                     'Cell $rowIndex:$columnIndex',
  //                     style: textStyleSubItems,
  //                   )))),
  //         ));
  List<ExpandableTableRow> subRows = List.generate(
      row,
      (rowIndex) => ExpandableTableRow(
            height: 50,
            firstCell: Container(
                color: primaryColor,
                margin: const EdgeInsets.all(1),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Sub Row $rowIndex',
                      style: textStyleSubItems,
                    ),
                  ),
                )),
            children: List<Widget>.generate(
                col - 1,
                (columnIndex) => Container(
                    color: primaryColor,
                    margin: const EdgeInsets.all(1),
                    child: Center(
                        child: Text(
                      'Cell $rowIndex:$columnIndex',
                      style: textStyleSubItems,
                    )))),
          ));
  //Creation rows
  List<ExpandableTableRow> rows = List.generate(
      row,
      (rowIndex) => ExpandableTableRow(
            height: 50,
            firstCell: Container(
                color: primaryColor,
                margin: const EdgeInsets.all(1),
                child: Center(
                    child: Text(
                  'Row $rowIndex',
                  style: textStyle,
                ))),
            legend: rowIndex == 0
                ? Container(
                    color: primaryColor,
                    margin: const EdgeInsets.all(1),
                    child: const Center(
                      child: Text(
                        'Expandible Row...',
                        style: textStyle,
                      ),
                    ),
                  )
                : null,
            children: rowIndex == 0
                ? subRows
                : List<Widget>.generate(
                    col - 1,
                    (columnIndex) => Container(
                        color: primaryColor,
                        margin: const EdgeInsets.all(1),
                        child: Center(
                            child: Text(
                          'Cell $rowIndex:$columnIndex',
                          style: textStyle,
                        )))),
          ));

  return ExpandableTable(
    headerHeight: 80,
    rows: rows,
    header: header,
    scrollShadowColor: accentColor,
  );
}
