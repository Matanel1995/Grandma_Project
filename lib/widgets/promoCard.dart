// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/models/variables.dart';

class promoCard extends StatelessWidget {
  final MyUser user;

  promoCard(this.user);

  @override
  // Widget build(BuildContext context) {
  //   return AspectRatio(
  //     aspectRatio: 2.62 / 3,
  //     child: Container(
  //       margin: EdgeInsets.only(right: 15.0),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20),
  //         image: DecorationImage(
  //             fit: BoxFit.cover, image: NetworkImage(user.photoUrl)),
  //       ),
  //       child: Container(
  //         child: Align(
  //           alignment: Alignment(0, 0.77),
  //           child: Text(
  //             user.userName,
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.w500,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             gradient: LinearGradient(
  //                 begin: Alignment.bottomRight,
  //                 stops: const [
  //                   0.1,
  //                   0.9
  //                 ],
  //                 colors: [
  //                   Colors.black.withOpacity(.8),
  //                   Colors.black.withOpacity(.1)
  //                 ])),
  //       ),
  //     ),
  //   );
  // }

  // Widget build(BuildContext context) {
  //   return Container(
  //     height: 60,
  //     margin: EdgeInsets.only(right: 15.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.5),
  //           spreadRadius: 1,
  //           blurRadius: 5,
  //           offset: Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: 12),
  //           child: CircleAvatar(
  //             radius: 20,
  //             backgroundImage: NetworkImage(user.photoUrl),
  //           ),
  //         ),
  //         Expanded(
  //           child: Text(
  //             user.userName,
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w500,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.6),
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
            child: Text(
              user.userName,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
