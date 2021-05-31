
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/2017.dart';
import 'package:flutter_basic/2018.dart';
import 'package:flutter_basic/2019.dart';
import 'package:flutter_basic/2020.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_basic/login_page.dart';

class TabPage extends StatefulWidget {


  @override
  _TabPageState createState() => _TabPageState();
}


class _TabPageState extends State<TabPage> {

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar : AppBar(
            backgroundColor: Color(0xffFFFF9090),
            centerTitle: true,

          ),
          body:Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [

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
                            Container(

                              width : MediaQuery.of(context).size.width-30,

                              /*child:
                              Image.asset('user-2.png', width: 30, height: 30,),*/
                              child:
                              Text("${snapshot.data.displayName}님",
                              textAlign: TextAlign.right,
                                style: TextStyle(fontSize:18,fontWeight: FontWeight.bold, height: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
                Image.asset('images/tab2.png',width: 1200, height: 200,),
                Padding(padding: EdgeInsets.only(top:80.0)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onSurface: Color(0xffFFFF9090),
                    shape: StadiumBorder(),
                    primary: Color(0xffFFFF9090),
                  ),
                  child: Text('   연도 선택   ',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white),),
                  onPressed: (){
                    print('연도 선택');
                  },

                ),
                Padding(padding: EdgeInsets.all(8.0)),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      onSurface: Color(0xffFFE0E0E0),
                      primary: Color(0xffFFE0E0E0),
                    ),
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context)
                      {return one_page();}),
                    );
                  },
                  label: Text("   2017", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
                  icon: Icon(Icons.music_note,color: Colors.black),
                ),
                Padding(padding: EdgeInsets.all(0.0)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    onSurface: Color(0xffFFE0E0E0),
                    primary: Color(0xffFFE0E0E0),
                  ),
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context)
                      {return two_page();}),
                    );
                  },
                  label: Text("   2018", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),),
                  icon: Icon(Icons.multitrack_audio,color: Colors.black),
                ),

                Padding(padding: EdgeInsets.all(0.0)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    onSurface: Color(0xffFFE0E0E0),
                    primary: Color(0xffFFE0E0E0),
                  ),
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context)
                      {return three_page();}),
                    );
                  },
                  label: Text("   2019", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),),
                  icon: Icon(Icons.mic,color: Colors.black),
                ),
                Padding(padding: EdgeInsets.all(0.0)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    onSurface: Color(0xffFFE0E0E0),
                    primary: Color(0xffFFE0E0E0),
                  ),
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context)
                      {return four_page();}),
                    );
                  },
                  label: Text("   2020", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),),
                  icon: Icon(Icons.play_circle_outline,color: Colors.black),
                ),



              ],
            ),
          ),
          backgroundColor: Color(0xfff7eded)
      );

  }

}