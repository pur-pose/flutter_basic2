//어느 화면을 보여줄까?
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'tab_page.dart';

class RootPage extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return TabPage();

  }
}

