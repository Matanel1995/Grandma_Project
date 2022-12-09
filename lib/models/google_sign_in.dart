import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_signin/models/user.dart';

class GoogleSingInPovider extends ChangeNotifier {
  BuildContext context;
  late MyUser currentUser;
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  GoogleSingInPovider(this.context);

  final userRef = FirebaseFirestore.instance.collection('User');

  Future googleLogin() async {
    //make a connection via google services
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      DocumentSnapshot<Map<String, dynamic>> doc;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      //add user details to our DB
      await FirebaseFirestore.instance
          .collection('User')
          .doc(googleUser.id)
          .set({
        'userId': googleUser.id,
        'userName': googleUser.displayName,
        'photoUrl': googleUser.photoUrl,
        'email': googleUser.email,
      });
    } on PlatformException catch (err) {
      var massage = "An error occurred, please try again.";
      if (err.message != null) {
        massage = err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(massage),
        ),
      );
    } catch (err) {
      debugPrint(err.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    //print('in logout function!');
    await googleSignIn.disconnect().whenComplete(() async {
      FirebaseAuth.instance.signOut();
    });
  }
}
