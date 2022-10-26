import 'dart:async';

import 'package:flutter/material.dart';

import '../../components/appDrawer.dart';
import '../../size.dart';
import 'dashboard/dashboard.dart';
import 'portfolio/portfolio.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int current = 0;
  // bool shrink = SizeConfig.width <= 1200, tab = SizeConfig.width <= 950;

  List<Widget> tabs = [DashBoard(), PortFolio()];

  changeTab(int index) {
    setState(() {
      current = index;
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
        AppDrawer(changeTab: changeTab),
        Expanded(child: tabs[current]),
      ],
    );
  }
}
