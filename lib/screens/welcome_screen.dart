// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/home_screen.dart';

import '../models/user.dart';
import 'Login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            var userId = paresProvider(snapshot.data!.providerData.toString());
            initCurrentUser(userId).then((value) {});
            return HomeScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Somthing went wrong'),
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }

  Future initCurrentUser(String userId) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('User').doc(userId);
    await docRef.get().then((doc) => {
          if (doc.exists)
            {
              currentUser =
                  MyUser.fromFirestore(doc.data() as Map<String, dynamic>),
            }
        });
  }

  String paresProvider(String info) {
    List<String> data = info.split(",");
    String userId = data[data.length - 1];
    userId = userId.split(':')[1];
    userId = userId.trim();
    userId = userId.substring(0, userId.length - 2);
    return userId;
  }
}
