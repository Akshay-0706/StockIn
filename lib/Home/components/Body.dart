import 'package:flutter/material.dart';
import 'package:stockin/about/about.dart';
import 'package:stockin/home/components/dashboard.dart';
import 'package:stockin/stock/stock.dart';

import '../../components/app_drawer.dart';
import '../../indices/indices.dart';
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppDrawer(
            changeTab: changeTab,
            current: current,
          ),
        ),
        Expanded(
            flex: 6,
            child: current == 0
                ? DashBoard(changeTab: changeTab)
                : current == 2
                    ? Stock(code: code, name: name)
                    : tabs[current]),
      ],
    );
  }
}
