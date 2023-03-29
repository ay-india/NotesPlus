import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/src/auth/authservice.dart';

import 'package:notes_app/src/screen/home_page.dart';
import 'package:notes_app/src/widgets/signinbutton.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // final auth = FirebaseAuth.instance;
  // final user = FirebaseAuth.instance.currentUser;
  bool showSignin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 120,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                image: DecorationImage(
                  image: AssetImage('asset/images/logo.png'),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(1),
                      blurRadius: 6,
                      spreadRadius: 6,
                      blurStyle: BlurStyle.outer)
                ]),
          ),
          showSignin
              ? Center(
                  child: InkWell(
                    onTap: () {
                      AuthService().signInWithGoogle(context);
                      // Timer(Duration(seconds: 4),
                      //     () => AuthService().isLogin(context));

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Container(
                      // clipBehavior: Clip.antiAlias,
                      width: 200,
                      padding: EdgeInsets.fromLTRB(1, 6, 1, 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Image.asset(
                            'asset/images/google.png',
                            width: 35.34,
                            // height: 50,
                          ),
                          Text(
                            "Sign in with Google",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      )),
    );
  }
}
