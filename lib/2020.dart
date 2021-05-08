import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/main.dart';
import 'package:flutter_basic/tab_page.dart';
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

//점수 카운트//

/*정답 알림 문구
  if(true){
    print('정답! 둠칫둠칫!');
  }
  var game_score = 0;
  for(var i = 0 ; i<20; i++) async {

}*/

int count = 0;
int score = 0;

//파이어스토어 DB연동//
Future musicList() async {
  if (count == 0) {
    sublist.clear();
    score = 0;
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
    count++;
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
                if (snapshot.hasData) {
                  return Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)), //상단 여백 설정//
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)), //모서리 둥글게//
                            boxShadow: ([
                              BoxShadow(color: Colors.white, blurRadius: 1.0)
                            ])),
                        height: 280,
                        width: 380,
                        //문제 박스 크기//
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[0].Question, //파이어스토어 0번째 퀘스쳔 데이터 끌고오기//
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3.5),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      /*보기 가져오기*/

                      /*1번째*/
                      Padding(padding: EdgeInsets.all(10.0)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQuery.of(context).size.width-20,40),
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[0].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            score++;
                            print (score);
                            Get.off(two_game());
                          } //다음 문제 페이지 이동//
                          ),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090), //버튼 색상 설정//
                          ),
                          child: Text(
                            sublist[5].Answer,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(two_game());
                          } //다음 문제 페이지 이동//
                          ),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(two_game());
                          } //다음 문제 페이지 이동//
                          ),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[3].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(two_game());
                          } //다음 문제 페이지 이동//
                          ),
                    ],
                  ));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(' '),
                  );
                }
              })),
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
    return WillPopScope(
      child: Scaffold(
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
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(20.0)),

                        /*보기 가져오기*/
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          height: 280,
                          width: 380,
                          padding: EdgeInsets.only(
                              left: 20, top: 20, bottom: 20, right: 20),
                          child: Text(
                            sublist[1].Question,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 3),
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
                            child: Text(
                              sublist[11].Answer,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Get.off(three_game());
                            }),
                        /*2번째*/
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onSurface: Color(0xffFFFF9090),
                              shape: StadiumBorder(),
                              primary: Color(0xffFFFF9090),
                            ),
                            child: Text(
                              sublist[8].Answer,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Get.off(three_game());
                            }),

                        /*3번째*/
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onSurface: Color(0xffFFFF9090),
                              shape: StadiumBorder(),
                              primary: Color(0xffFFFF9090),
                            ),
                            child: Text(
                              sublist[1].Answer,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              score++;
                              print (score);
                              Get.off(three_game());
                            }),

                        /*4번째*/
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onSurface: Color(0xffFFFF9090),
                              shape: StadiumBorder(),
                              primary: Color(0xffFFFF9090),
                            ),
                            child: Text(
                              sublist[4].Answer,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Get.off(three_game());
                            }),
                      ],
                    ));
                  } else {
                    return Padding(
                      child: Text('aaaaaaaaa'),
                    );
                  }
                  ;
                })),
        backgroundColor: Color(0xfff7eded),
      ),
      onWillPop: () {},
    );
  }
}

//3번째 문제 페이지//
class three_game extends StatefulWidget {
  @override
  _three_gameState createState() => _three_gameState();
}

class _three_gameState extends State<three_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[2].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(four_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(four_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(four_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(four_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//4번째 문제 페이지//
class four_game extends StatefulWidget {
  @override
  _four_gameState createState() => _four_gameState();
}

class _four_gameState extends State<four_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[3].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(five_gmae());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(five_gmae());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(five_gmae());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(five_gmae());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//5번째 문제 페이지//
class five_gmae extends StatefulWidget {
  @override
  _five_gmaeState createState() => _five_gmaeState();
}

class _five_gmaeState extends State<five_gmae> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[4].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(six_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(six_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(six_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(six_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//6번째 문제 페이지//
class six_game extends StatefulWidget {
  @override
  _six_gameState createState() => _six_gameState();
}

class _six_gameState extends State<six_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[5].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(seven_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(seven_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(seven_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(seven_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//7번째 문제 페이지//
class seven_game extends StatefulWidget {
  @override
  _seven_gameState createState() => _seven_gameState();
}

class _seven_gameState extends State<seven_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[6].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eight_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eight_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eight_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eight_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//8번째 문제 페이지//
class eight_game extends StatefulWidget {
  @override
  _eight_gameState createState() => _eight_gameState();
}

class _eight_gameState extends State<eight_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[7].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(nine_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(nine_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(nine_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(nine_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//9번째 문제 페이지//
class nine_game extends StatefulWidget {
  @override
  _nine_gameState createState() => _nine_gameState();
}

class _nine_gameState extends State<nine_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[8].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(ten_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(ten_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(ten_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(ten_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//10번째 문제 페이지//
class ten_game extends StatefulWidget {
  @override
  _ten_gameState createState() => _ten_gameState();
}

class _ten_gameState extends State<ten_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[9].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eleven_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eleven_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eleven_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eleven_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//11번째 문제 페이지//
class eleven_game extends StatefulWidget {
  @override
  _eleven_gameState createState() => _eleven_gameState();
}

class _eleven_gameState extends State<eleven_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[10].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(twelve_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(twelve_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(twelve_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(twelve_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//12번째 문제 페이지//
class twelve_game extends StatefulWidget {
  @override
  _twelve_gameState createState() => _twelve_gameState();
}

class _twelve_gameState extends State<twelve_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[11].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(thirteen_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(thirteen_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(thirteen_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(thirteen_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//13번째 문제 페이지//
class thirteen_game extends StatefulWidget {
  @override
  _thirteen_gameState createState() => _thirteen_gameState();
}

class _thirteen_gameState extends State<thirteen_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[12].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(fourteen_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(fourteen_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(fourteen_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(fourteen_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//14번째 문제 페이지//
class fourteen_game extends StatefulWidget {
  @override
  _fourteen_gameState createState() => _fourteen_gameState();
}

class _fourteen_gameState extends State<fourteen_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[13].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(fifteen_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(fifteen_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(fifteen_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(fifteen_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//15번째 문제 페이지//
class fifteen_game extends StatefulWidget {
  @override
  _fifteen_gameState createState() => _fifteen_gameState();
}

class _fifteen_gameState extends State<fifteen_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[14].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(sixteen_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(sixteen_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(sixteen_game());
                          }),
                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(sixteen_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//16번째 문제 페이지//
class sixteen_game extends StatefulWidget {
  @override
  _sixteen_gameState createState() => _sixteen_gameState();
}

class _sixteen_gameState extends State<sixteen_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[15].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(seventeen_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(seventeen_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(seventeen_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(seventeen_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//17번째 문제 페이지//
class seventeen_game extends StatefulWidget {
  @override
  _seventeen_gameState createState() => _seventeen_gameState();
}

class _seventeen_gameState extends State<seventeen_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[16].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eighteen_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eighteen_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eighteen_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(eighteen_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//18번째 문제 페이지//
class eighteen_game extends StatefulWidget {
  @override
  _eighteen_gameState createState() => _eighteen_gameState();
}

class _eighteen_gameState extends State<eighteen_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[17].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(nineteen_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(nineteen_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(nineteen_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(nineteen_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//19번째 문제 페이지//
class nineteen_game extends StatefulWidget {
  @override
  _nineteen_gameState createState() => _nineteen_gameState();
}

class _nineteen_gameState extends State<nineteen_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[18].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(twenty_game());
                          }),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(twenty_game());
                          }),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(twenty_game());
                          }),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Get.off(twenty_game());
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}

//20번째 문제 페이지//
class twenty_game extends StatefulWidget {
  @override
  _twenty_gameState createState() => _twenty_gameState();
}

class _twenty_gameState extends State<twenty_game> {
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
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(20.0)),

                      /*보기 가져오기*/
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 280,
                        width: 380,
                        padding: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text(
                          sublist[19].Question,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 3),
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
                          child: Text(
                            sublist[11].Answer,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {}),
                      /*2번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[8].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {}),

                      /*3번째*/

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[16].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {}),

                      /*4번째*/
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Color(0xffFFFF9090),
                            shape: StadiumBorder(),
                            primary: Color(0xffFFFF9090),
                          ),
                          child: Text(
                            sublist[4].Answer,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          //클릭시 결과공개 팝업창으로 넘어가게//
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text('결과 공개'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('점수 : $score'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('다시시작'),
                                          onPressed: () {
                                            sublist.clear();
                                            count = 0;
                                            Get.off(TabPage());
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('종료'),
                                          onPressed: () {
                                            sublist.clear();
                                            count = 0;
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ]);
                                });
                          }),
                    ],
                  ));
                } else {}
                ;
              })),
      backgroundColor: Color(0xfff7eded),
    );
  }
}
