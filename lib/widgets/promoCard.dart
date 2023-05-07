// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/models/user.dart';

class promoCard extends StatelessWidget {
  final MyUser user;
  promoCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).cardColor,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 14,
              backgroundImage: NetworkImage(user.photoUrl),
            ),
          ),
          Expanded(
            child: buildTextSmall(context, user.userName),
          ),
        ],
      ),
    );
  }
}
