import 'dart:async';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockin/database/data/stocks.dart';
import 'package:stockin/database/server/api.dart';
import 'package:stockin/database/server/regular_stock.dart';
import 'package:stockin/database/server/stocks.dart';
import 'package:stockin/global.dart';
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
  late bool loggedIn = true;
  late String token, newToken;
  String mode = "Buy", hintText = "Search", newStock = "";
  late int qty;
  late double price;

  late Future<StockLtp> futureStock;
  late Future<Stocks> futureInvestedStock;
  late List<StockInvested> investedStocks;
  Map<String, double> stockQty = {};
  double totalInvestment = 0,
      currentInvestment = 0,
      totalTodaysPnl = 0,
      totalLtp = 0,
      totalPnl = 0;
  bool portfolioIsReady = false;
  List<CircularStocks> circularStocks = [];
  List<String> stocksForSell = [];

  late Timer timer, tokenTimer;

  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  FutureOr<void> getInvestedStocks() {
    print("Outside");
    futureInvestedStock =
        fetchStocks(pref.getString("email")!.replaceAll(".", "_"));
    futureInvestedStock.then((value) {
      investedStocks = value.investedStocks;
      getLtp();
      print("Inside");
      timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => getLtp());
    }).catchError((error) {
      getLtp();
    });
  }

  void checkSession() async {
    newToken = globalToken.getToken();
    if (newToken.isNotEmpty) token = newToken;
    if (loggedIn && JwtDecoder.isExpired(token)) {
      setState(() {
        loggedIn = false;
      });
    } else if (!JwtDecoder.isExpired(token)) {
      setState(() {
        loggedIn = true;
      });
    }
  }

  @override
  void initState() {
    sharedPrefInstance.then((value) {
      pref = value;
      prefIsReady = true;
      loggedIn = pref.containsKey("email");
      token = pref.getString("token")!;
      checkSession();

      tokenTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        checkSession();
      });

      getInvestedStocks();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    tokenTimer.cancel();
  }

  void getLtp() {
    int i = 0;
    for (var element in investedStocks) {
      stockQty[element.symbol] = element.qty;
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
    newStock = stocksForSell.isEmpty ? "" : stocksForSell[0];
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
    if (newStock.isNotEmpty && qty != 0 && price != 0) {
      modifyStocks();
    }
  }

  void modifyStocks() async {
    putStock(pref.getString("email")!.replaceAll(".", "_"), mode, newStock,
            price.toString(), qty.toString())
        .then((value) {
      setState(() {
        newStock = "";
        hintText = "Search";
        qtyController.clear();
        priceController.clear();
      });

      timer.cancel();
      getInvestedStocks();
    });
  }

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
                  height: getHeight(300),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PortfolioView(pref: pref),
                            const Spacer(),
                            PortfolioCards(
                              totalInvestment: totalInvestment,
                              currentInvestment: currentInvestment,
                              totalTodaysPnl: totalTodaysPnl,
                              totalPnl: totalPnl,
                            ),
                            const Spacer(),
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
                              SizedBox(
                                height: getHeight(250),
                                child: CiruclarChart(
                                    investedStocks: circularStocks),
                              ),
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
              if (prefIsReady && loggedIn && portfolioIsReady)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Buy or Sell Stocks",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: getHeight(20),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: getHeight(20)),
                    addRemoveStocks(context),
                  ],
                ),
              SizedBox(height: getHeight(40)),
              if (prefIsReady &&
                  loggedIn &&
                  portfolioIsReady &&
                  investedStocks.isNotEmpty)
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (mode == "Sell")
          CustomDropdownButton2(
            hint: newStock,
            value: newStock,
            buttonWidth: getHeight(300),
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
                newStock = value!;
              });
            },
          ),
        if (mode == "Buy")
          SizedBox(
            width: getHeight(300),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    hintText.isEmpty ? newStock : "",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: getHeight(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                StockSearchBar(
                  searchList: stocks,
                  hintText: hintText,
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
                    if (item != null) {
                      hintText = "";
                      setState(() {
                        newStock = (item as Map<String, String>).values.last;
                      });
                    } else {
                      hintText = "Search";
                    }
                  },
                ),
              ],
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
        const Spacer(),
        SizedBox(width: getHeight(20)),
        CustomTextField(
          onChanged: onChanged,
          forQty: true,
          maxQty: mode == "Sell" ? stockQty[newStock]! : 0,
          forBuy: mode == "Buy",
          controller: qtyController,
        ),
        SizedBox(width: getHeight(20)),
        CustomTextField(
          onChanged: onChanged,
          forQty: false,
          maxQty: mode == "Sell" ? stockQty[newStock]! : 0,
          forBuy: mode == "Buy",
          controller: priceController,
        ),
        SizedBox(width: getHeight(20)),
        InkWell(
          onTap: () => validator(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: getHeight(100),
            height: getHeight(50),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Done",
                style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: getHeight(16),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SizedBox(width: getHeight(20)),
      ],
    );
  }
}
