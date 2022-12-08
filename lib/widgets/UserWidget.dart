import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          userName,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          email,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          userId,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          photoUrl,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
