import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../database/data/investedStocks.dart';

class CiruclarChart extends StatefulWidget {
  const CiruclarChart({super.key, required this.investedStocks});
  final List<CircularStocks> investedStocks;

  @override
  State<CiruclarChart> createState() => _CiruclarChartState();
}

class _CiruclarChartState extends State<CiruclarChart> {
  final bool _shouldAlwaysShowScrollbar = false;
  late String selectedMode;
  late final List<String>? modeList;
  late LegendItemOverflowMode overflowMode;
  late String selectedPosition;
  late final List<String>? positionList;
  late LegendPosition position;

  @override
  void initState() {
    selectedMode = 'wrap';
    modeList = <String>['wrap', 'none', 'scroll'].toList();
    position = LegendPosition.auto;
    selectedPosition = 'auto';
    positionList = <String>['auto', 'bottom', 'left', 'right', 'top'].toList();
    overflowMode = LegendItemOverflowMode.wrap;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(
          position: position,
          isVisible: true,
          overflowMode: overflowMode,
          shouldAlwaysShowScrollbar: _shouldAlwaysShowScrollbar),
      series: defaultCircularSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  ///Get the default circular series
  List<DoughnutSeries<CircularStocks, String>> defaultCircularSeries() {
    return <DoughnutSeries<CircularStocks, String>>[
      DoughnutSeries<CircularStocks, String>(
        dataSource: widget.investedStocks,
        xValueMapper: (CircularStocks data, _) => data.stockName,
        yValueMapper: (CircularStocks data, _) => data.investedPartition,
        startAngle: 90,
        endAngle: 90,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelPosition: ChartDataLabelPosition.outside),
      ),
    ];
  }

  ///Change the legend position
  void onPositionTypeChange(String item) {
    setState(() {
      selectedPosition = item;
      if (selectedPosition == 'auto') {
        position = LegendPosition.auto;
      }
      if (selectedPosition == 'bottom') {
        position = LegendPosition.bottom;
      }
      if (selectedPosition == 'right') {
        position = LegendPosition.right;
      }
      if (selectedPosition == 'left') {
        position = LegendPosition.left;
      }
      if (selectedPosition == 'top') {
        position = LegendPosition.top;
      }
    });
  }

  ///Change the legend overflow mode
  void onModeTypeChange(String item) {
    setState(() {
      selectedMode = item;
      if (selectedMode == 'wrap') {
        overflowMode = LegendItemOverflowMode.wrap;
      }
      if (selectedMode == 'scroll') {
        overflowMode = LegendItemOverflowMode.scroll;
      }
      if (selectedMode == 'none') {
        overflowMode = LegendItemOverflowMode.none;
      }
    });
  }
}
