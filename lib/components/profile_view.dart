import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
    required this.shrink,
    required this.pref,
  }) : super(key: key);

  final bool shrink;
  final SharedPreferences pref;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: getHeight(40),
          height: getHeight(40),
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: const Color(0xFF2F3438),
              ),
              borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              width: getHeight(40),
              height: getHeight(40),
              imageUrl: pref.getString("image")!,
              placeholder: (context, url) => Container(
                width: getHeight(40),
                height: getHeight(40),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle),
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 4,
                ),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.error_outline,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ),
        if (!shrink) SizedBox(width: getHeight(14)),
        if (!shrink)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hello!",
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: getHeight(14),
                ),
              ),
              Text(
                pref.getString("name")!,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: getHeight(16),
                ),
              ),
            ],
          )
      ],
    );
  }
}
