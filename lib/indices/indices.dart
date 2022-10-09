import 'package:flutter/material.dart';
import 'package:stockin/indices/components/body.dart';

class Indices extends StatelessWidget {
  const Indices({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: IndicesBody(),
    );
  }
}