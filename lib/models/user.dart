import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyUser {
  final String id;
  final String userName;
  final String photoUrl;
  final String email;
  //final String displayName;

  const MyUser({
    required this.id,
    required this.userName,
    required this.photoUrl,
    required this.email,
    //required this.displayName,
  });

  factory MyUser.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    return MyUser(
        id: snapshot['userId'],
        userName: snapshot['userName'],
        photoUrl: snapshot['photoUrl'],
        email: snapshot['email']);
  }
}
