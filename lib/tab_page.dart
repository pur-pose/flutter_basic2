import 'package:flutter/material.dart';
import 'package:flutter_basic/2017.dart';
import 'package:flutter_basic/2018.dart';
import 'package:flutter_basic/2019.dart';
import 'package:flutter_basic/2020.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_basic/login_page.dart';
import 'package:flutter_basic/main.dart';

class TabPage extends StatefulWidget {
  final User user;
  TabPage(this.user);

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
                Image.asset('images/logo2.png',width: 600,height: 250,),
                Padding(padding: EdgeInsets.only(top:70.0)),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text('   연도 선택   ',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  onPressed: (){
                    print('연도 선택');
                  },
                  textColor: Colors.white,
                  color: Color(0xffFFFF9090),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                RaisedButton.icon(
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context)
                      {return one_page();}),
                    );
                  },
                  label: Text("   2017", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),),
                  icon: Icon(Icons.music_note,),
                ),
                Padding(padding: EdgeInsets.all(0.0)),
                RaisedButton.icon(
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context)
                      {return two_page();}),
                    );
                  },
                  label: Text("   2018", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),),
                  icon: Icon(Icons.multitrack_audio,),
                ),

                Padding(padding: EdgeInsets.all(0.0)),
                RaisedButton.icon(
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context)
                      {return three_page();}),
                    );
                  },
                  label: Text("   2019", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),),
                  icon: Icon(Icons.mic,),
                ),
                Padding(padding: EdgeInsets.all(0.0)),
                RaisedButton.icon(
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context)
                      {return four_page();}),
                    );
                  },
                  label: Text("   2020", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),),
                  icon: Icon(Icons.play_circle_outline,),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xfff7eded)
      );

  }

}