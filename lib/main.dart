import 'package:flutter/material.dart';
import 'package:flutter_basic/2017.dart';
import 'package:flutter_basic/login_page.dart';
import 'package:flutter_basic/root_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_basic/tab_page.dart';
import 'package:flutter_basic/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp()); //main 화면이 my app 클래스를 호출//
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Appbar',
      theme: ThemeData(fontFamily: 'BM-HANNA'),
      home: LoginPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  final User user;
  MyPage(this.user);
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
            StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (snapshot.data == null) {
                  return LoginPage();
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${snapshot.data.displayName}님 환영합니다.",
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),

                      ],
                    ),
                  );
                }
              },
            ),
            RaisedButton(
              child: Text('  게임시작  ',
                          style: TextStyle(fontWeight: FontWeight.bold),),
              onPressed: (){
                Navigator.push(context,
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
                FirebaseAuth.instance.signOut();
                _googleSignIn.signOut();

                Navigator.push(context,
                  MaterialPageRoute<void>(builder: (BuildContext context)
                  {return LoginPage();}),
                );
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


