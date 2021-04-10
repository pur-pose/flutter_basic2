import 'package:flutter/material.dart';

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
                  onPressed: () { print('Button Click');},
                  label: Text("   2017", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),),
                  icon: Icon(Icons.music_note,),
                ),
                Padding(padding: EdgeInsets.all(0.0)),
                RaisedButton.icon(
                  onPressed: () { print('Button Click');},
                  label: Text("   2018", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),),
                  icon: Icon(Icons.multitrack_audio,),
                ),

                Padding(padding: EdgeInsets.all(0.0)),
                RaisedButton.icon(
                  onPressed: () { print('Button Click');},
                  label: Text("   2019", style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),),
                  icon: Icon(Icons.mic,),
                ),
                Padding(padding: EdgeInsets.all(0.0)),
                RaisedButton.icon(
                  onPressed: () { print('Button Click');},
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