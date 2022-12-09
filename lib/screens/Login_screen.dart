// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_signin/models/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  final elizabethImage = 'assets/pictures/queen-elizabeth-removebg.png';
  final fireWorksImage = 'assets/pictures/fireWorks.png';

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  elizabethImage,
                  width: 300,
                  height: 200,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 300,
                  height: 300,
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: Text(
                    "Hi Family!\nAs you know grandma loves to see your activities. Share with her your day to day and make her happy!!",
                    style: GoogleFonts.gabriela(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please sign in to use the app!',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // SizedBox(
                //   height: 50,
                // ),
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
        backgroundColor: Color.fromARGB(90, 188, 212, 230));
  }
}
