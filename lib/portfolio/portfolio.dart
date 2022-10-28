import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockin/portfolio/components/body.dart';

class PortFolio extends StatelessWidget {
  const PortFolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PortFolioBody(),
    );
  }
}
