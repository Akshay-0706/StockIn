import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockin/global.dart';
import 'package:stockin/size.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.isHovered,
    required this.shrink,
    required this.icon,
  }) : super(key: key);

  final bool isHovered, shrink;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: GlobalParams.duration,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            isHovered
                ? const Color(0xFF1CA7EC).withOpacity(0.5)
                : const Color(0xFF1CA7EC),
            isHovered
                ? const Color(0xFF1F2F98).withOpacity(0.5)
                : const Color(0xFF1F2F98),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? const Color(0xFF1CA7EC).withOpacity(0.2)
                : const Color(0xFF1CA7EC).withOpacity(0.4),
            offset: const Offset(2, 3),
            blurRadius: 10,
          ),
          BoxShadow(
            color: isHovered
                ? const Color(0xFF1F2F98).withOpacity(0.2)
                : const Color(0xFF1F2F98).withOpacity(0.4),
            offset: const Offset(2, 3),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, size: getHeight(16)),
            if (!shrink) SizedBox(width: getHeight(10)),
            if (!shrink)
              Text(
                "Login/Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: getHeight(12)),
              ),
          ],
        ),
      ),
    );
  }
}
