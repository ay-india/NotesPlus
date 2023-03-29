import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/src/screen/home_page.dart';
import 'package:notes_app/src/screen/sign_in_page.dart';
import 'package:notes_app/src/util/routes_name.dart';
import 'package:notes_app/src/util/utils.dart';

class AuthService {
  //handle auth  state

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return SignInPage();
          }
        });
  }

  // sigin in with google
  signInWithGoogle(BuildContext context) async {
    //trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    //obtain the auth details from the request

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // once signed in , return the user credential

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.homeScreen, (route) => false);
      Utils().toastMessage(
          '${FirebaseAuth.instance.currentUser!.email!} is logged in successfully');
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  // Sign out
  signOut(BuildContext context) async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signOut();
    // await googleUser.signOut();
    FirebaseAuth.instance.signOut().then((value) {
      
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.signInPage, (route) => false);
      Utils().toastMessage('Logged out successfully');
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }
}

/*
class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage())));
    }
    // else {
    //   Timer(
    //       Duration(seconds: 3),
    //       () => Navigator.push(
    //           context, MaterialPageRoute(builder: (context) => SignInPage())));
    // }
  }
}
*/
