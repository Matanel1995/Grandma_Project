// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_signin/models/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final elizabethImage = 'assets/pictures/queen-elizabeth-removebg.png';

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text(
          'G r a n d m a    P r o j e c t',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.blueGrey,
        // theme: ThemeData(
        //     primarySwatch: Colors.blueGrey,
        //     accentColor: Color.fromARGB(255, 6, 0, 10),
        //     canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        //     fontFamily: 'Raleway',
        //     textTheme: ThemeData.light().textTheme.copyWith(
        //         bodyText1: const TextStyle(
        //           color: Color.fromRGBO(20, 51, 51, 1),
        //         ),
        //         bodyText2: const TextStyle(
        //           color: Color.fromRGBO(20, 51, 51, 1),
        //         ),
        //         subtitle1: const TextStyle(
        //           fontSize: 20,
        //           fontFamily: 'RobotoCondensed',
        //           fontWeight: FontWeight.bold,
        //         ))),
        centerTitle: true,
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
                        'Sign in with google',
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
    );
  }
}
