// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/screens/home_screen.dart';

import 'Login_screen.dart';

class WelcomeScreen extends StatelessWidget {
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
            // going in to the app.
            return HomeScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Somthing went wrong'),
            );
          } else {
            print("do i get here?");
            // here is the queen
            return LoginPage();
          }
        },
      ),
    );
  }
}
