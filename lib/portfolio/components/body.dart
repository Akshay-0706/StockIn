import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockin/components/profileView.dart';
import 'package:stockin/database/data/stocks.dart';
import 'package:stockin/database/server/api.dart';
import 'package:stockin/database/server/regularStock.dart';
import 'package:stockin/database/server/stocks.dart';
import 'package:stockin/global.dart';
import 'package:stockin/portfolio/components/circularChart.dart';
import 'package:stockin/size.dart';
import 'package:stockin/theme.dart';

import '../../components/stockSearchBar.dart';
import '../../database/data/investedStocks.dart';
import '../../database/server/chart.dart';

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

  @override
  void initState() {
    futureInvestedStock = fetchStocks("krishshah@gmail_com");
    futureInvestedStock.then((value) {
      investedStocks = value.investedStocks;
      getLtp();
    }).catchError((error) => print("Error in getting stock: $error"));

    sharedPrefInstance.then((value) {
      pref = value;
      setState(() {
        prefIsReady = true;
        loggedIn = pref.containsKey("email");
      });
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

  void getLtp() {
    int i = 0;
    for (var element in investedStocks) {
      futureStock = fetchLtp("${element.symbol}.NS");
      futureStock.then((value) {
        element.ltp = value.regularMarketPrice;
        element.prevClose = value.previoudClose;
        i++;
        if (i == investedStocks.length) calRemaining();
      }).catchError((error) => print("Error in getting ltp: $error"));
    }
  }

  void calRemaining() {
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
      totalLtp += element.ltp;
    }
    totalPnl = totalLtp - totalInvestment;
    for (var element in investedStocks) {
      stocksForSell.add(element.symbol);
      circularStocks.add(CircularStocks(
          stockName: element.symbol,
          investedPartition:
              double.parse((element.ltp / totalLtp * 100).toStringAsFixed(2))));
    }
    stock = stocksForSell[0];
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
              // if (!portfolioIsReady)
              // const CircularProgressIndicator(),
              if (prefIsReady && portfolioIsReady)
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
                            PortfolioView(
                              pref: pref,
                            ),
                            SizedBox(height: getHeight(40)),
                            Text(
                              "Buy or Sell Stocks",
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: getHeight(20),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  if (mode == "Sell")
                                    CustomDropdownButton2(
                                      hint: stock,
                                      value: stock,
                                      buttonWidth: getHeight(150),
                                      buttonHeight: getHeight(50),
                                      dropdownItems: stocksForSell,
                                      iconEnabledColor:
                                          Theme.of(context).primaryColorDark,
                                      buttonDecoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .drawerTheme
                                            .backgroundColor,
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.4),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      dropdownDecoration: BoxDecoration(
                                        color: const Color(0xFF131C2D),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      icon: const FaIcon(
                                          Icons.arrow_drop_down_rounded),
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
                                                  .contains(
                                                      query.toLowerCase()))
                                              .toList();
                                        },
                                        overlaySearchListItemBuilder: (item) {
                                          return Container(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              (item as Map<String, String>)
                                                  .values
                                                  .last,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          );
                                        },
                                        onItemSelected: (item) {
                                          setState(() {
                                            searchStock =
                                                (item as Map<String, String>)
                                                    .values
                                                    .last;
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
                                    iconEnabledColor:
                                        Theme.of(context).primaryColorDark,
                                    buttonDecoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .drawerTheme
                                          .backgroundColor,
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.4),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    dropdownDecoration: BoxDecoration(
                                      color: const Color(0xFF131C2D),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    icon: const FaIcon(
                                        Icons.arrow_drop_down_rounded),
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
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Done",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                          if (portfolioIsReady)
                            CiruclarChart(investedStocks: circularStocks),
                          if (!portfolioIsReady)
                            const CircularProgressIndicator()
                        ],
                      )),
                    ],
                  ),
                ),
              SizedBox(height: getHeight(40)),
              if (portfolioIsReady)
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
                    DataColumn(label: Text("Present value")),
                    DataColumn(label: Text("P&L")),
                    DataColumn(label: Text("P&L chg.")),
                  ],
                  source: DataSource(context: context, stocks: investedStocks),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.onChanged,
    required this.forQty,
  }) : super(key: key);
  final Function onChanged;
  final bool forQty;

  @override
  Widget build(BuildContext context) {
    String reg = forQty ? r'[0-9]' : r'[0-9.]';
    return Container(
      width: getHeight(100),
      decoration: BoxDecoration(
          color: Theme.of(context).drawerTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
        child: TextFormField(
          textAlign: TextAlign.center,
          onChanged: (value) =>
              forQty ? onChanged(true, value) : onChanged(false, value),
          validator: (value) => forQty
              ? null
              : double.tryParse(value!) == null
                  ? "Invalid double"
                  : null,
          keyboardType: TextInputType.number,
          inputFormatters: [
            // for below version 2 use this
            FilteringTextInputFormatter.allow(RegExp(reg)),
          ],
          cursorRadius: const Radius.circular(8),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: forQty ? "Quantity" : "Price",
            hintStyle: TextStyle(fontSize: getHeight(16)),
          ),
        ),
      ),
    );
  }
}

class PortfolioCards extends StatelessWidget {
  const PortfolioCards({
    Key? key,
    required this.totalInvestment,
    required this.currentInvestment,
    required this.totalTodaysPnl,
    required this.totalPnl,
  }) : super(key: key);

  final double totalInvestment;
  final double currentInvestment;
  final double totalTodaysPnl;
  final double totalPnl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PortfolioCard(
          title: "Total investment",
          value: totalInvestment,
          checkSign: false,
        ),
        const Spacer(),
        PortfolioCard(
          title: "Current value",
          value: currentInvestment,
          checkSign: false,
        ),
        const Spacer(),
        PortfolioCard(
          title: "Today's P&L",
          value: totalTodaysPnl,
          checkSign: true,
        ),
        const Spacer(),
        PortfolioCard(
          title: "Total P&L",
          value: totalPnl,
          checkSign: true,
        ),
      ],
    );
  }
}

class PortfolioView extends StatelessWidget {
  const PortfolioView({
    Key? key,
    required this.pref,
  }) : super(key: key);
  final SharedPreferences pref;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: getHeight(100),
          height: getHeight(100),
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.18),
                  offset: const Offset(8, 10),
                  blurRadius: 20,
                )
              ],
              borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              pref.getString("image")!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: getHeight(40)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pref.getString("name")!,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(28),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              pref.getString("email")!,
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: getHeight(18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PortfolioCard extends StatelessWidget {
  const PortfolioCard({
    Key? key,
    required this.value,
    required this.title,
    required this.checkSign,
  }) : super(key: key);
  final String title;
  final double value;
  final bool checkSign;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: checkSign
            ? value >= 0
                ? Colors.greenAccent.withOpacity(0.05)
                : Colors.redAccent.withOpacity(0.05)
            : Theme.of(context).drawerTheme.backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: EdgeInsets.all(getHeight(16)),
        child: Column(
          children: [
            Text(
              value.toStringAsFixed(2),
              style: TextStyle(
                  color: checkSign
                      ? value >= 0
                          ? Colors.greenAccent
                          : Colors.redAccent
                      : Theme.of(context).primaryColorDark,
                  fontSize: getHeight(20),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
          ],
        ),
      ),
    );
  }
}
