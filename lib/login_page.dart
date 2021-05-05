import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_basic/main.dart';
import 'package:flutter_basic/tab_page.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';




class LoginPage extends StatelessWidget {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFF9090),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: <Widget>
          [Padding(padding: EdgeInsets.all(20.0)),
            Image.asset('images/logo.jpg', width: 500, height: 200,),
            Image.asset('images/dancing.jpg', width: 300, height: 140,),
            Padding(padding: EdgeInsets.all(20.0)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onSurface: Color(0xffFFFF9090),
                  primary: Color(0xffFFFF9090),
                ),
                child: Text('   Login   ',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white),),
                  onPressed: () {
                    _handleSignIn().then((user) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(
                              builder: (context) => MyPage(user)));
                      print(user); });},
                      )

                      /*SignInButton(
                Buttons.Google,
                onPressed: () {
                _handleSignIn().then((user) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyPage(user)));
                  print(user);
                });
              },
            )*/
          ],
          )
      ),
      backgroundColor: Color(0xfff7eded),
    );
  }
  Future<User> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    User user = (await _auth.signInWithCredential(GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken)))
        .user;
    print("signed in " + user.displayName);
    return user;
  }
}