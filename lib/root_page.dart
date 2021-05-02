//어느 화면을 보여줄까?
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/login_page.dart';
import 'package:flutter_basic/main.dart';
import 'package:flutter_basic/tab_page.dart';

class RootPage extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
      if(snapshot.hasData) {
        return  MyPage(snapshot.data);
      } else {
        return LoginPage();
      }
      },
    );

  }
}

