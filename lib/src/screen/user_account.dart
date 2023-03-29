import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/src/auth/authservice.dart';
import 'package:notes_app/src/screen/sign_in_page.dart';
import 'package:notes_app/src/util/app_constant.dart';

import '../util/routes_name.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              // margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(6),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetwee,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'JustNotes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color.fromARGB(255, 2, 49, 90)),
                  ),
                ],
              ),
            ),
            Divider(thickness: 2),
            SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(100),
                  // color: Colors.red,
                  image: DecorationImage(
                    image: NetworkImage(
                      FirebaseAuth.instance.currentUser!.photoURL!,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.displayName!,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                AuthService().signOut(context);
                // AuthService().handleAuthState();
                // Navigator.pushNamedAndRemoveUntil(
                //     context, RouteName.signInPage, (route) => false);
                // Navigator.pushNamed(context,
                //     MaterialPageRoute(builder: (BuildContext context) {
                //   return SignInPage();
                // }));
              },
              child: Container(
                height: 50,
                width: 220,
                decoration: BoxDecoration(
                  color: AppConstant.theme,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
