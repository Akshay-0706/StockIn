import 'package:flutter/material.dart';
import 'package:stockin/Home/components/Body.dart';
import 'package:stockin/size.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    return const Scaffold(
      body: HomeBody(),
    );
  }
}
