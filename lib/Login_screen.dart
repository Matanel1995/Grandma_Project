// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_signin/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final elizabethImage = 'assets/pictures/queen-elizabeth-removebg.png';

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'G r a n d m a    P r o j e c t',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset(
              elizabethImage,
              width: 300,
              height: 200,
            ),
            SizedBox(
              height: 150,
            ),
            Text(
              'Please sign in to use the app!',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSingInPovider>(context, listen: false);
                  provider.googleLogin();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(327, 50),
                    primary: Colors.white70,
                    elevation: 15,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
                child: Container(
                  width: 250,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 50,
                        child: Image.network(
                            'https://flutter-ui.s3.us-east-2.amazonaws.com/social_media_buttons/google-icon.png'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Sing in with google',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Kanit',
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
