import 'package:flutter/material.dart';
import 'package:flutter_basic/main.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class one_page extends StatefulWidget {
  @override
  _one_pageState createState() => _one_pageState();
}

class _one_pageState extends State<one_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar : AppBar(
          title: Text('둠칫! 둠칫!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xffFFFF9090),
    centerTitle: true,
    ),
    body : Center()
    ,backgroundColor: Color(0xfff7eded),);
  }
}
