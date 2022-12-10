import 'package:flutter/material.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/widgets/promoCard.dart';

class UserWidget extends StatelessWidget {
  final String userId;
  final String email;
  final String userName;
  final String photoUrl;

  UserWidget(
      {required this.email,
      required this.photoUrl,
      required this.userId,
      required this.userName});

  factory UserWidget.fromMyUser(MyUser user) {
    return UserWidget(
        userId: user.id,
        userName: user.userName,
        photoUrl: user.photoUrl,
        email: user.email);
  }

  @override
  Widget build(BuildContext context) {
    MyUser user = MyUser(
        id: userId, userName: userName, photoUrl: photoUrl, email: email);
    return promoCard(user);
  }
}
