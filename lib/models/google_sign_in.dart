import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/models/variables.dart';

class GoogleSingInPovider extends ChangeNotifier {
  BuildContext context;
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

      //CHECK IF USER ALLREADY EXIST
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('User').doc(googleUser.id);
      docRef.get().then((doc) => {
            if (doc.exists)
              {
                //Create instance of user with the DB parameters
                currentUser =
                    MyUser.fromFirestore(doc.data() as Map<String, dynamic>)
              }
            else
              {
                //Add to db
                docRef.set({
                  'userId': googleUser.id,
                  'userName': googleUser.displayName,
                  'photoUrl': googleUser.photoUrl,
                  'email': googleUser.email,
                  'groupList': [],
                  'currentGroupId': '0',
                  'isViewer': false,
                }),
                //Create an instance of myUser
                currentUser = MyUser(
                  id: googleUser.id,
                  userName: googleUser.displayName.toString(),
                  photoUrl: googleUser.photoUrl.toString(),
                  email: googleUser.email,
                  currentGroupId: currentUser.currentGroupId,
                  groupsList: currentUser.groupsList,
                  isViewer: false,
                )
              }
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
    await googleSignIn.disconnect().whenComplete(() async {
      FirebaseAuth.instance.signOut();
    });
    currentUser = MyUser(
        id: '0',
        userName: '0',
        photoUrl: '0',
        email: '0',
        currentGroupId: '0',
        groupsList: [],
        isViewer: false);
  }
}
