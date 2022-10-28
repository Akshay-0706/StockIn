import 'package:flutter/material.dart';
import 'package:stockin/about/about.dart';
import 'package:stockin/stock/stock.dart';
import 'package:stockin/watchlist/watchlist.dart';

import '../../components/appDrawer.dart';
import '../../indices/indices.dart';
import 'dashboard.dart';
import '../../portfolio/portfolio.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int current = 0;
  String code = "", name = "";
  // bool shrink = SizeConfig.width <= 1200, tab = SizeConfig.width <= 950;

  List<Widget> tabs = [
    const PortFolio(),
    const PortFolio(),
    const Indices(),
    const Indices(),
    const Watchlist(),
    const About()
  ];

  changeTab(int index, bool visitStock, [String code = "", String name = ""]) {
    setState(() {
      current = index;
      if (visitStock) {
        this.code = code;
        this.name = name;
      } else {
        this.code = "";
        this.name = "";
      }
    });
  }

  // late Timer timer;
  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(
    //     const Duration(seconds: 1),
    //     (Timer t) => setState(() {
    //           print(SizeConfig.width);
    //           if (SizeConfig.width <= 1200) {
    //             shrink = true;
    //           } else {
    //             shrink = false;
    //           }
    //         }));
  }

  @override
  void dispose() {
    super.dispose();
    // timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppDrawer(
          changeTab: changeTab,
          current: current,
        ),
        Expanded(
            child: current == 0
                ? DashBoard(changeTab: changeTab)
                : current == 3
                    ? Stock(code: code, name: name)
                    : tabs[current]),
      ],
    );
  }
}
