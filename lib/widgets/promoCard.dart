// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_signin/models/user.dart';

class promoCard extends StatelessWidget {
  final MyUser user;

  promoCard(this.user);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(user.photoUrl)),
        ),
        child: Container(
          child: Align(
            alignment: Alignment(0, 0.77),
            child: Text(
              user.userName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  stops: const [
                    0.1,
                    0.9
                  ],
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.1)
                  ])),
        ),
      ),
    );
  }
}
