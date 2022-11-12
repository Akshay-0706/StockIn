import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MarketMoodRenderer extends StatelessWidget {
  MarketMoodRenderer({
    Key? key,
    required this.value,
  }) : super(key: key);

  final double value;
  final List<Color> gradient = [
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
    Colors.redAccent
  ];
  final List<double> stops = [0.25, 0.5, 0.75, 1];

  @override
  Widget build(BuildContext context) {
    if (value <= 75) {
      gradient.removeAt(3);
      stops.removeAt(3);
    }
    if (value <= 50) {
      gradient.removeAt(2);
      stops.removeAt(2);
    }
    if (value <= 25) {
      gradient.removeAt(1);
      stops.removeAt(1);
    }

    return SfRadialGauge(
      enableLoadingAnimation: true,
      key: UniqueKey(),
      animationDuration: 2500,
      axes: <RadialAxis>[
        RadialAxis(
            axisLineStyle: const AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
            radiusFactor: 0.8,
            showTicks: false,
            showLastLabel: true,
            maximum: 150,
            axisLabelStyle: const GaugeTextStyle(),
            // Added custom axis renderer that extended from RadialAxisRenderer
            onCreateAxisRenderer: () => CustomAxisRenderer(),
            pointers: <GaugePointer>[
              NeedlePointer(
                  enableAnimation: true,
                  gradient: LinearGradient(colors: <Color>[
                    Theme.of(context).primaryColor.withOpacity(0.5),
                    Theme.of(context).primaryColor.withOpacity(0.9),
                  ], stops: const <double>[
                    0.25,
                    0.75
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  animationType: AnimationType.easeOutBack,
                  value: value > 100 ? 100 : value,
                  animationDuration: 1300,
                  needleStartWidth: 4,
                  needleEndWidth: 8,
                  needleLength: 0.8,
                  knobStyle: const KnobStyle(
                    knobRadius: 0,
                  )),
              RangePointer(
                  value: value > 100 ? 100 : value,
                  width: 0.15,
                  sizeUnit: GaugeSizeUnit.factor,
                  animationDuration: 1300,
                  animationType: AnimationType.easeOutBack,
                  gradient: SweepGradient(colors: gradient, stops: stops),
                  enableAnimation: true),
            ])
      ],
    );
  }
}

class CustomAxisRenderer extends RadialAxisRenderer {
  CustomAxisRenderer() : super();

  List<double> range = [0, 25, 50, 75, 100];

  /// Generated the 9 non-linear interval labels from 0 to 100
  /// instead of actual generated labels.
  @override
  List<CircularAxisLabel> generateVisibleLabels() {
    final List<CircularAxisLabel> visibleLabels = <CircularAxisLabel>[];
    for (int i = 0; i < range.length; i++) {
      final double labelValue = range[i];
      final CircularAxisLabel label = CircularAxisLabel(
          axis.axisLabelStyle,
          i == range.length - 1
              ? ">${labelValue.toInt()}"
              : labelValue.toInt().toString(),
          i,
          false);
      label.value = labelValue;
      visibleLabels.add(label);
    }

    return visibleLabels;
  }

  /// Returns the factor(0 to 1) from value to place the labels in an axis.
  @override
  double valueToFactor(double value) {
    return value / 100;
  }
}
