import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../size.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.onChanged,
    required this.forQty,
    required this.forBuy,
    required this.maxQty,
    required this.controller,
  }) : super(key: key);
  final Function onChanged;
  final bool forQty, forBuy;
  final TextEditingController controller;
  final double maxQty;

  @override
  Widget build(BuildContext context) {
    String reg = forQty ? r'[0-9]' : r'[0-9.]';
    return Container(
      width: getHeight(150),
      decoration: BoxDecoration(
          color: Theme.of(context).drawerTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
        child: TextFormField(
          onChanged: (value) =>
              forQty ? onChanged(true, value) : onChanged(false, value),
          controller: controller,
          validator: (value) => forQty
              ? null
              : double.tryParse(value!) == null
                  ? "Invalid double"
                  : null,
          keyboardType: TextInputType.number,
          inputFormatters: [
            // for below version 2 use this
            FilteringTextInputFormatter.allow(RegExp(reg)),
            if (!forBuy && forQty) NumericalRangeFormatter(min: 1, max: maxQty),
          ],
          cursorRadius: const Radius.circular(8),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: forQty ? "Quantity" : "Price",
            hintStyle: TextStyle(fontSize: getHeight(16)),
          ),
        ),
      ),
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return const TextEditingValue().copyWith(
        text: min.toStringAsFixed(0),
        selection: TextSelection.fromPosition(
          TextPosition(offset: min.toStringAsFixed(0).length),
        ),
      );
    } else {
      return int.parse(newValue.text) > max
          ? const TextEditingValue().copyWith(
              text: max.toStringAsFixed(0),
              selection: TextSelection.fromPosition(
                TextPosition(offset: max.toStringAsFixed(0).length),
              ),
            )
          : newValue;
    }
  }
}
