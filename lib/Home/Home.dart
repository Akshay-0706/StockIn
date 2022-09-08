import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockin/Home/components/Body.dart';

import '../size.dart';

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
