// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Login_screen.dart';
import 'LoggedIn_screen.dart';

class HomePage extends StatelessWidget {
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
            print('i have the data!');
            return LoggedInWidget();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Somthing went wrong'),
            );
          } else {
            print("do i get here?");
            return LoginPage();
          }
        },
      ),
    );
  }
}
