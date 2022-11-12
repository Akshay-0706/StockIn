// import 'package:flutter/material.dart';

// import '../../size.dart';

// class VolumePainter extends CustomPainter {
  
//   VolumePainter({
//     required this.volume,
//   })  : gainPaint = Paint()..color = Colors.greenAccent.withOpacity(0.7),
//         lossPaint = Paint()..color = Colors.redAccent.withOpacity(0.7);

//   final List<dynamic> volume;
//   late List<int> convertedVolume;

//   final Paint gainPaint;
//   final Paint lossPaint;

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Generate bars
//     List<Bar> bars = generateBars(size);

//     // Paint bars
//     for (Bar bar in bars) {
//       canvas.drawRect(
//           Rect.fromLTWH(bar.centerX - (bar.width / 2), size.height - bar.height,
//               bar.width, bar.height),
//           bar.paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

//   List<Bar> generateBars(Size size) {
//     convertedVolume = List<int>.generate(volume.length, (index) {
//       return volume[index] ?? 0;
//     });

//     final pixelsPerTimeWindow = size.width / volume.length;

//     final pixelsPerStockOrder = size.height / getMaxVolume(convertedVolume);

//     List<Bar> bars = [];
//     for (var i = 0; i < convertedVolume.length; i++) {
//       bars.add(Bar(
//           width: SizeConfig.width * 0.5 / convertedVolume.length,
//           height: convertedVolume[i] * pixelsPerStockOrder,
//           centerX: (i + 1) * pixelsPerTimeWindow,
//           paint: isGain(i) ? gainPaint : lossPaint));
//     }
//     return bars;
//   }

//   dynamic getMaxVolume(List<int> volume) {
//     List<int> tempVolume =
//         List<int>.generate(volume.length, (index) => volume[index]);

//     tempVolume.sort();
//     return tempVolume[tempVolume.length - 1];
//   }

//   bool isGain(int i) {
//     if (i == 0) {
//       return true;
//     } else {
//       return convertedVolume[i] > convertedVolume[i - 1];
//     }
//   }
// }

// class Bar {
//   final double width;
//   final double height;
//   final double centerX;
//   final Paint paint;

//   Bar(
//       {required this.width,
//       required this.height,
//       required this.centerX,
//       required this.paint});
// }