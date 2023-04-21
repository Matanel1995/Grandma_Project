// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/home_screen.dart';

import '../models/user.dart';
import 'Login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            var userId = paresProvider(snapshot.data!.providerData.toString());
            print('THE USER ID IS NOW:' + userId);
            () async {
              print('BEFORE INITCURRENT USER !!!!');
              await initCurrentUser(userId);
              print("AFTER INITCURRENYUSER!!!!");
            }.call();
            print('current user current group id: ' +
                currentUser.getCurrentGroupId);
            return HomeScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: buildText(context, 'Somthing went wrong'),
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }

  Future initCurrentUser(String userId) async {
    print("IN INIT CURR USER THE ID IS : " + userId);
    // DocumentReference docRef =
    //     FirebaseFirestore.instance.collection('User').doc(userId);
    // print('GOT THE DOC!!!!');
    // print(docRef.toString());
    usersList = await currentUser.getUsersUsingServer([userId]) as List<MyUser>;
    currentUser = usersList[0];
    print("current user" + currentUser.toString());
    print("gurrent user group " + currentUser.currentGroupId);
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
