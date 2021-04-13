import 'package:flutter/material.dart';
import 'package:flutter_basic/2017.dart';
import 'package:flutter_basic/login_page.dart';
import 'package:flutter_basic/root_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_basic/tab_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp()); //main 화면이 my app 클래스를 호출//
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appbar',
      theme: ThemeData(
      ),
      home: LoginPage(),
    );
  }
}

class MyPage extends StatelessWidget {
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
            RaisedButton(
              child: Text('  게임시작  ',
                          style: TextStyle(fontWeight: FontWeight.bold),),
              onPressed: (){
                .push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context)
                {return TabPage();}),
                );
              },
              textColor: Colors.white,
              color: Color(0xffFF5E5E5E),

            ),
            RaisedButton(
              child: Text('  로그아웃  ',
                style: TextStyle(fontWeight: FontWeight.bold),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              textColor: Colors.black,
              color: Color(0xffFFE0E0E0),

            ),
          ],


          ),
          ),
        backgroundColor: Color(0xfff7eded),
    );

  }
}


