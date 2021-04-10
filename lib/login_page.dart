import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Color(0xffFFFF9090),
        centerTitle: true,
      ),
      body : Center(
          child: Column(children: <Widget>
          [Padding(padding: EdgeInsets.all(20.0)),
            Image.asset('images/logo.jpg',width: 500,height: 200,),
            Image.asset('images/dancing.jpg',width: 300, height: 140,),
            Padding(padding: EdgeInsets.all(20.0)),
            SignInButton(
              Buttons.Google,
              onPressed: () {},)
          ],
          )
      ),
      backgroundColor: Color(0xfff7eded),
    );
  }
}