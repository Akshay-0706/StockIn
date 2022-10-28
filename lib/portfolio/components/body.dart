import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/portfolio/components/circularChart.dart';
import 'package:stockin/size.dart';

import '../../database/data/investedStocks.dart';

class PortFolioBody extends StatefulWidget {
  const PortFolioBody({super.key});

  @override
  State<PortFolioBody> createState() => _PortFolioBodyState();
}

class _PortFolioBodyState extends State<PortFolioBody> {
  List<CircularStocks> investedStocks = [
    CircularStocks(stockName: "AMIROG", investedAmt: 50.63),
    CircularStocks(stockName: "GULPOLY", investedAmt: 25.03),
    CircularStocks(stockName: "PARADEEP", investedAmt: 13.02),
    CircularStocks(stockName: "EXIDEIND", investedAmt: 6.65),
    CircularStocks(stockName: "GPIL", investedAmt: 4.67),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getHeight(40), horizontal: getHeight(20)),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                "My Portfolio",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: getHeight(32),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: getHeight(40)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "Invested Stocks",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: getHeight(24),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CiruclarChart(investedStocks: investedStocks),
                    ],
                  )),
                  const Spacer(),
                ],
              ),
              SizedBox(height: getHeight(40)),
              PaginatedDataTable(
                columnSpacing: 100,
                arrowHeadColor: Theme.of(context).primaryColor,
                showCheckboxColumn: false,
                header: const Text("Stocks"),
                rowsPerPage: 5,
                columns: const [
                  DataColumn(label: Text("Symbol")),
                  DataColumn(label: Text("Qty")),
                  DataColumn(label: Text("Buy Avg.")),
                  DataColumn(label: Text("Buy value")),
                  DataColumn(label: Text("LTP")),
                  DataColumn(label: Text("Presemt value")),
                  DataColumn(label: Text("P&L")),
                  DataColumn(label: Text("P&L chg.")),
                ],
                source: DataSource(context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
