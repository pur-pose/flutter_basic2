import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/main.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class four_page extends StatefulWidget {
  @override
  _four_pageState createState() => _four_pageState();
}

//파이어스토어 DB연동//
Future musicList() async {
  sublist.clear();
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection("2020").limit(20).get();

  for (int i = 0; i < querySnapshot.size; i++) {
    var cid = querySnapshot.docs[i].id;
    var Question = querySnapshot.docs[i].data()["Question"];
    var Answer = querySnapshot.docs[i].data()["Answer"];

    sublist.add(SubgameList(cid: cid, Question: Question, Answer: Answer));
    print(i);
    print(sublist[i].cid);
  }

  return sublist;
}

class SubgameList {
  String cid;
  String Question;
  String Answer;

  SubgameList({this.cid, this.Question, this.Answer});
}

List<SubgameList> sublist = [SubgameList()];

//



class _four_pageState extends State<four_page> {

  @override
  Widget build(BuildContext context) {
    /*var firestore;
     return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('2017').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child : CircularProgressIndicator());
          }*/
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '둠칫! 둠칫!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffFFFF9090),
        centerTitle: true,
      ),

      /*문제 끌어오기*/
      body: Center(
          child: FutureBuilder(
            future: musicList(),
            builder: (context, snapshot) {
              if (snapshot.hasData != null) {
                return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget> [
                        Padding(padding: EdgeInsets.all(20.0)), //상단 여백 설정//
                        Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(10.0)), //모서리 둥글게//
                           boxShadow: ([BoxShadow(color: Colors.white, blurRadius: 1.0)])
                         ),
                         height: 280, width: 380, //문제 박스 크기//
                         padding: EdgeInsets.only(left: 20, top:20, bottom: 20, right: 20),
                         child: Text(
                           sublist[0].Question, //파이어스토어 0번째 퀘스쳔 데이터 끌고오기//
                           style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, height: 3.5),
                           textAlign: TextAlign.center,
                       ),
                       ),

                        /*보기 가져오기*/

                        /*1번째*/
                       Padding(padding: EdgeInsets.all(10.0)),
                           ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               onSurface: Color(0xffFFFF9090),
                               shape: StadiumBorder(),
                               primary: Color(0xffFFFF9090),
                             ),


                             child: Text(sublist[0].Answer,
                             style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold, height: 1,
                             color: Colors.white),
                             textAlign: TextAlign.center,
                           ),
                           onPressed: (){Get.off(two_game());} //다음 문제 페이지 이동//
                           ),
                        /*2번째*/
                           ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onSurface: Color(0xffFFFF9090),
                              shape: StadiumBorder(),
                              primary: Color(0xffFFFF9090), //버튼 색상 설정//
                            ),
                            child: Text(sublist[5].Answer,
                              style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold, height: 1,
                                  color: Colors.white),
                                  textAlign: TextAlign.center,
                            ),
                               onPressed: (){Get.off(two_game());} //다음 문제 페이지 이동//
                            ),

                        /*3번째*/

                           ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onSurface: Color(0xffFFFF9090),
                              shape: StadiumBorder(),
                              primary: Color(0xffFFFF9090),
                            ),
                            child: Text(sublist[4].Answer,
                              style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, height: 1,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                               onPressed: (){Get.off(two_game());} //다음 문제 페이지 이동//
                            ),

                        /*4번째*/
                           ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onSurface: Color(0xffFFFF9090),
                              shape: StadiumBorder(),
                              primary: Color(0xffFFFF9090),
                            ),
                            child: Text(sublist[3].Answer,
                              style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, height: 1,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                               onPressed: (){Get.off(two_game());} //다음 문제 페이지 이동//
                            ),



              ],

                    )
                );
              }else{};
              }
      )
      ),
      backgroundColor: Color(0xfff7eded),
    );
  }
}




//2번째 문제 페이지//
class two_game extends StatefulWidget {
  @override
  _two_gameState createState() => _two_gameState();
}

class _two_gameState extends State<two_game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '둠칫! 둠칫!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffFFFF9090),
        centerTitle: true,
      ),

      /*문제 끌어오기*/
      body: Center(
          child: FutureBuilder(
              future: musicList(),
              builder: (context, snapshot) {
                if (snapshot.hasData != null) {
                  return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget> [
                          Padding(padding: EdgeInsets.all(20.0)),

                          /*보기 가져오기*/
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            height: 280, width: 380,
                            padding: EdgeInsets.only(left: 20, top:20, bottom: 20, right: 20),
                            child: Text(
                              sublist[3].Question,
                              style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, height: 3),
                              textAlign: TextAlign.center,
                            ),
                          ),


                          /*1번째*/
                          Padding(padding: EdgeInsets.all(10.0)),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onSurface: Color(0xffFFFF9090),
                                shape: StadiumBorder(),
                                primary: Color(0xffFFFF9090),

                              ),

                              child: Text(sublist[11].Answer,
                                style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold, height: 1,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: (){}),
                          /*2번째*/
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onSurface: Color(0xffFFFF9090),
                                shape: StadiumBorder(),
                                primary: Color(0xffFFFF9090),
                              ),
                              child: Text(sublist[8].Answer,
                                style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, height: 1,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: (){}),

                          /*3번째*/

                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onSurface: Color(0xffFFFF9090),
                                shape: StadiumBorder(),
                                primary: Color(0xffFFFF9090),
                              ),
                              child: Text(sublist[16].Answer,
                                style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, height: 1,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: (){}),

                          /*4번째*/
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onSurface: Color(0xffFFFF9090),
                                shape: StadiumBorder(),
                                primary: Color(0xffFFFF9090),
                              ),
                              child: Text(sublist[4].Answer,
                                style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, height: 1,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: (){}),



                        ],

                      )
                  );
                }else{};
              }
          )
      ),
      backgroundColor: Color(0xfff7eded),
    );
  }
  }
