import 'package:flutter/material.dart';
import 'package:stockin/portfolio/components/body.dart';

class PortFolio extends StatelessWidget {
  const PortFolio({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PortFolioBody(),
    );
  }
}
