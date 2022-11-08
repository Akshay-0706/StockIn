import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../size.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.onChanged,
    required this.forQty,
  }) : super(key: key);
  final Function onChanged;
  final bool forQty;

  @override
  Widget build(BuildContext context) {
    String reg = forQty ? r'[0-9]' : r'[0-9.]';
    return Container(
      width: getHeight(100),
      decoration: BoxDecoration(
          color: Theme.of(context).drawerTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getHeight(10)),
        child: TextFormField(
          textAlign: TextAlign.center,
          onChanged: (value) =>
              forQty ? onChanged(true, value) : onChanged(false, value),
          validator: (value) => forQty
              ? null
              : double.tryParse(value!) == null
                  ? "Invalid double"
                  : null,
          keyboardType: TextInputType.number,
          inputFormatters: [
            // for below version 2 use this
            FilteringTextInputFormatter.allow(RegExp(reg)),
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
