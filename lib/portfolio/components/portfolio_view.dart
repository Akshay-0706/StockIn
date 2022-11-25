import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../size.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({
    Key? key,
    required this.pref,
  }) : super(key: key);
  final SharedPreferences pref;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: getHeight(100),
          height: getHeight(100),
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.18),
                  offset: const Offset(8, 10),
                  blurRadius: 20,
                )
              ],
              borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              width: getHeight(100),
              height: getHeight(100),
              imageUrl: pref.getString("image")!,
              placeholder: (context, url) => Container(
                width: getHeight(100),
                height: getHeight(100),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle),
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 4,
                ),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.person,
                size: getHeight(80),
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ),
        SizedBox(width: getHeight(40)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pref.getString("name")!,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(28),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: getHeight(10)),
            Text(
              pref.getString("email")!,
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: getHeight(18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
