import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Components/appDrawer.dart';
import '../../Components/navBar.dart';
import '../../size.dart';
import 'first/first.dart';
import 'second/second.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AppDrawer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getHeight(20)),
              const NavBar(),
              SizedBox(height: getHeight(40)),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(flex: 3, child: First()),
                    Expanded(flex: 1, child: Second()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
