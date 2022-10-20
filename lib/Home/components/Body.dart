import 'package:flutter/material.dart';

import '../../components/appDrawer.dart';
import 'dashboard/first.dart';
import 'second/second.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int current = 0;

  List<Widget> tabs = [DashBoard(), PortFolio()];

  changeTab(int index) {
    setState(() {
      current = index;
    });
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
