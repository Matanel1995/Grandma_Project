import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInPovider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      print('start with google login function!');
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      print('got user!');
      final googleAuth = await googleUser.authentication;
      print('got user auth!');
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      print('got cardetinals!');
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('done with goole login function!');
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    print('in logout function!');
    await googleSignIn.disconnect().whenComplete(() async {
      FirebaseAuth.instance.signOut();
    });
  }
}
