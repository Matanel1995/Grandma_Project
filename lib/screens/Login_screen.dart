// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_signin/models/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_signin/main.dart';

class LoginPage extends StatelessWidget {
  final elizabethImage = 'assets/pictures/queen-elizabeth-removebg.png';
  final fireWorksImage = 'assets/pictures/fireWorks.png';

  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: buildTitle(context, 'Grandma Project'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  elizabethImage,
                  width: 300,
                  height: 200,
                ),
                Container(
                  width: 300,
                  height: 300,
                  child: buildText(context,
                      'Hi Family!\nAs you know grandma loves to see your activities. Share with her your day to day and make her happy!!'),
                ),
                buildText(context, 'Please sign in to use the app!'),
                SignInButton(
                  Buttons.Google,
                  elevation: 4,
                  onPressed: () {
                    final provider = Provider.of<GoogleSingInPovider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
