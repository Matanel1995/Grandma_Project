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
<<<<<<< HEAD
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
||||||| 609f1ea
      appBar: AppBar(
        title: Text(
          'G r a n d m a    P r o j e c t',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 28,
          ),
=======
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text(
          'G r a n d m a    P r o j e c t',
          style: Theme.of(context).textTheme.titleMedium,
>>>>>>> c85ca573baf1e552d43b9d59ab02cca1beff78ff
        ),
<<<<<<< HEAD
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
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
                padding: EdgeInsets.fromLTRB(0, 60, 0, 30),
                child: Text(
                  "Hi Family!\nAs you know grandma loves to see your activities. Share with her your day to day and make her happy!!",
                  style: GoogleFonts.gabriela(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Please sign in to use the app!',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SignInButton(
                Buttons.Google,
                elevation: 4,
||||||| 609f1ea
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
=======
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
>>>>>>> c85ca573baf1e552d43b9d59ab02cca1beff78ff
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSingInPovider>(context, listen: false);
                  provider.googleLogin();
                },
              ),
            ],
          ),
        ),
<<<<<<< HEAD
        backgroundColor: Color.fromARGB(90, 188, 212, 230));
||||||| 609f1ea
      ),
      backgroundColor: Colors.white,
    );
=======
      ),
    );
>>>>>>> c85ca573baf1e552d43b9d59ab02cca1beff78ff
  }
}
