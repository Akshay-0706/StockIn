import 'dart:async';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockin/database/data/stocks.dart';
import 'package:stockin/database/server/api.dart';
import 'package:stockin/database/server/regular_stock.dart';
import 'package:stockin/database/server/stocks.dart';
import 'package:stockin/portfolio/components/circular_chart.dart';
import 'package:stockin/size.dart';

import '../../components/stock_search_bar.dart';
import '../../database/data/invested_stocks.dart';
import 'custom_text_field.dart';
import 'portfolio_cards.dart';
import 'portfolio_view.dart';

class PortFolioBody extends StatefulWidget {
  const PortFolioBody({super.key});

  @override
  State<PortFolioBody> createState() => _PortFolioBodyState();
}

class _PortFolioBodyState extends State<PortFolioBody> {
  final Future<SharedPreferences> sharedPrefInstance =
      SharedPreferences.getInstance();
  late SharedPreferences pref;
  bool prefIsReady = false;
  late bool loggedIn;
  String mode = "Buy", searchStock = "";
  late String stock;
  late int qty;
  late double price;

  late Future<StockLtp> futureStock;
  late Future<Stocks> futureInvestedStock;
  late List<StockInvested> investedStocks;
  double totalInvestment = 0,
      currentInvestment = 0,
      totalTodaysPnl = 0,
      totalLtp = 0,
      totalPnl = 0;
  bool portfolioIsReady = false;
  List<CircularStocks> circularStocks = [];
  List<String> stocksForSell = [];

  TextEditingController controller = TextEditingController();

  late Timer timer;

  FutureOr<void> getInvestedStocks() {
    futureInvestedStock =
        fetchStocks(pref.getString("email")!.replaceAll(".", "_"));
    futureInvestedStock.then((value) {
      investedStocks = value.investedStocks;
      getLtp();
      timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => getLtp());
    }).catchError((error) {
      // print("Error: " + error);
    });
  }

  @override
  void initState() {
    sharedPrefInstance.then((value) {
      pref = value;
      setState(() {
        prefIsReady = true;
        loggedIn = pref.containsKey("email");
      });

      getInvestedStocks();
    });

    controller.addListener(() {
      controller.text = searchStock;
      controller.value = controller.value.copyWith(
        text: searchStock,
        selection: TextSelection.fromPosition(
          TextPosition(offset: searchStock.length),
        ),
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void getLtp() {
    int i = 0;
    for (var element in investedStocks) {
      futureStock = fetchLtp("${element.symbol}.NS");
      futureStock.then((value) {
        element.ltp = value.regularMarketPrice;
        element.prevClose = value.previoudClose;
        i++;
        if (i == investedStocks.length) calRemaining();
      }).catchError((error) {
        // print("${element.symbol} not modified!");
      });
    }
    if (investedStocks.isEmpty) calRemaining();
  }

  void calRemaining() {
    totalInvestment = 0;
    currentInvestment = 0;
    totalTodaysPnl = 0;
    totalLtp = 0;
    totalPnl = 0;

    for (var element in investedStocks) {
      element.presentValue =
          double.parse((element.ltp * element.qty).toStringAsFixed(2));
      element.pnl = double.parse(
          (element.presentValue - element.buyValue).toStringAsFixed(2));
      element.pnlChg = double.parse(
          (element.pnl / element.buyValue * 100).toStringAsFixed(2));
      element.todaysPnl = (element.ltp - element.prevClose) * element.qty;

      totalInvestment += element.buyValue;
      currentInvestment += element.presentValue;
      totalTodaysPnl += element.todaysPnl;
      totalLtp += element.ltp * element.qty;
    }
    totalPnl = totalLtp - totalInvestment;

    circularStocks = [];
    stocksForSell = [];
    for (var element in investedStocks) {
      stocksForSell.add(element.symbol);
      circularStocks.add(CircularStocks(
          stockName: element.symbol,
          investedPartition: double.parse(
              (element.ltp * element.qty / totalLtp * 100)
                  .toStringAsFixed(2))));
    }
    stock = stocksForSell.isNotEmpty ? stocksForSell[0] : "";
    setState(() {
      portfolioIsReady = true;
    });
  }

  void onChanged(bool forQty, String value) {
    if (forQty) {
      qty = int.parse(value);
    } else {
      price = double.parse(value);
    }
  }

  void validator() {
    if (stock.isNotEmpty && qty != 0 && price != 0) {}
  }

  void onSubmitted() {}

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "My Portfolio",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: getHeight(32),
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              SizedBox(height: getHeight(40)),
              if (prefIsReady && !loggedIn)
                Column(
                  children: [
                    SizedBox(height: getHeight(40)),
                    LottieBuilder.asset(
                      "assets/design/lottie_login.svg",
                      height: getHeight(400),
                      repeat: false,
                    ),
                    Text(
                      "Log in to see your portfolio",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: getHeight(22),
                      ),
                    ),
                  ],
                ),
              if (prefIsReady && loggedIn && !portfolioIsReady)
                const CircularProgressIndicator(),
              if (prefIsReady && loggedIn && portfolioIsReady)
                SizedBox(
                  height: getHeight(400),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PortfolioView(pref: pref),
                            SizedBox(height: getHeight(40)),
                            Text(
                              "Buy or Sell Stocks",
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: getHeight(20),
                                  fontWeight: FontWeight.bold),
                            ),
                            addRemoveStocks(context),
                            SizedBox(height: getHeight(20)),
                            PortfolioCards(
                              totalInvestment: totalInvestment,
                              currentInvestment: currentInvestment,
                              totalTodaysPnl: totalTodaysPnl,
                              totalPnl: totalPnl,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Stock Overview",
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: getHeight(24),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (portfolioIsReady && circularStocks.isNotEmpty)
                              CiruclarChart(investedStocks: circularStocks),
                            if (!portfolioIsReady)
                              const CircularProgressIndicator(),
                            if (portfolioIsReady && investedStocks.isEmpty)
                              Column(
                                children: [
                                  SizedBox(height: getHeight(40)),
                                  Text(
                                    "Add at least one stock to see overview",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: getHeight(20),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: getHeight(40)),
              if (portfolioIsReady && investedStocks.isNotEmpty)
                PaginatedDataTable(
                  columnSpacing: 100,
                  arrowHeadColor: Theme.of(context).primaryColor,
                  showCheckboxColumn: false,
                  header: const Text("Stocks"),
                  rowsPerPage:
                      investedStocks.length > 5 ? 5 : investedStocks.length,
                  columns: const [
                    DataColumn(label: Text("Symbol")),
                    DataColumn(label: Text("Qty")),
                    DataColumn(label: Text("Buy Avg.")),
                    DataColumn(label: Text("Buy value")),
                    DataColumn(label: Text("LTP")),
                    DataColumn(label: Text("Present value")),
                    DataColumn(label: Text("P&L")),
                    DataColumn(label: Text("P&L chg.")),
                  ],
                  source: DataSource(context: context, stocks: investedStocks),
                ),
              if (portfolioIsReady && loggedIn && investedStocks.isEmpty)
                Column(
                  children: [
                    SizedBox(height: getHeight(40)),
                    Text(
                      "Add a stock to see details",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: getHeight(20),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Row addRemoveStocks(BuildContext context) {
    return Row(
      children: [
        if (mode == "Sell")
          CustomDropdownButton2(
            hint: stock,
            value: stock,
            buttonWidth: getHeight(150),
            buttonHeight: getHeight(50),
            dropdownItems: stocksForSell,
            iconEnabledColor: Theme.of(context).primaryColorDark,
            buttonDecoration: BoxDecoration(
              color: Theme.of(context).drawerTheme.backgroundColor,
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            dropdownDecoration: BoxDecoration(
              color: const Color(0xFF131C2D),
              borderRadius: BorderRadius.circular(8),
            ),
            icon: const FaIcon(Icons.arrow_drop_down_rounded),
            iconSize: getHeight(20),
            onChanged: (value) {
              setState(() {
                stock = value!;
              });
            },
          ),
        if (mode == "Buy")
          SizedBox(
            width: getHeight(150),
            child: StockSearchBar(
              searchList: stocks,
              hintText: "Search",
              controller: controller,
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
                  child: Text(
                    (item as Map<String, String>).values.last,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              },
              onItemSelected: (item) {
                setState(() {
                  searchStock = (item as Map<String, String>).values.last;
                  stock = searchStock;
                });
              },
            ),
          ),
        SizedBox(width: getHeight(20)),
        CustomDropdownButton2(
          hint: mode,
          value: mode,
          buttonWidth: getHeight(100),
          buttonHeight: getHeight(50),
          dropdownItems: const ["Buy", "Sell"],
          iconEnabledColor: Theme.of(context).primaryColorDark,
          buttonDecoration: BoxDecoration(
            color: Theme.of(context).drawerTheme.backgroundColor,
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          dropdownDecoration: BoxDecoration(
            color: const Color(0xFF131C2D),
            borderRadius: BorderRadius.circular(8),
          ),
          icon: const FaIcon(Icons.arrow_drop_down_rounded),
          iconSize: getHeight(20),
          onChanged: (value) {
            setState(() {
              mode = value!;
            });
          },
        ),
        SizedBox(width: getHeight(20)),
        CustomTextField(
          onChanged: onChanged,
          forQty: true,
        ),
        SizedBox(width: getHeight(20)),
        CustomTextField(
          onChanged: onChanged,
          forQty: false,
        ),
        SizedBox(width: getHeight(20)),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: getHeight(100),
            height: getHeight(50),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Done",
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
        )
      ],
    );
  }
}
