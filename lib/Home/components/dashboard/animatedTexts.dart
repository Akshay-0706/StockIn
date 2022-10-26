import 'package:flutter/material.dart';

import '../../../size.dart';

class AnimatedTexts extends StatelessWidget {
  const AnimatedTexts({
    Key? key,
    required this.first,
    required this.second,
    required this.firstColor,
    required this.secondColor,
    required this.crossAxisAlignment,
  }) : super(key: key);
  final String first, second;
  final Color firstColor, secondColor;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 1),
      builder: (context, double value, child) => Opacity(
        opacity: value,
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              const SizedBox(height: 50),
              Text(
                first,
                style: TextStyle(
                  color: firstColor,
                  fontSize: getHeight(18),
                ),
              ),
              const SizedBox(height: 150),
              Text(
                second,
                style: TextStyle(
                  color: secondColor,
                  fontSize: getHeight(18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
