import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stockin/database/signIn.dart';

import '../size.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
    required this.shrink,
    required this.user,
  }) : super(key: key);

  final bool shrink;
  final User? user;

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
            child: Image.network(
              user!.photoURL!,
              fit: BoxFit.cover,
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
                user!.displayName!,
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
