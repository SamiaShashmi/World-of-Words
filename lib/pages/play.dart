import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class PlayPage extends StatefulWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {

  int time = 15;
  int score = 0;
  int life = 3;
  int level = 0;
  String madeWord = "";
  String alphabet = "abcdefghijklmnopqrstuvwxyz";
  late List<String>letters = [""];
  Timer? timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if(time == 0)
          {
            setState(() {
              time = 15;
              timer.cancel();
            });
          }
        else{
          setState(() {
            time--;
          });
        }

      },
    );
  }

  void generateRandomLetter() {
    Random r = new Random();
    for(int i = 0; i < 49; i++)
      {
        letters.add(alphabet[r.nextInt(alphabet.length)]);
      }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    generateRandomLetter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff2a2828),
                Color(0xff785252),
              ]),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Level: $level',
                  style: TextStyle(fontSize: 25, color: Color(0xffde5757)),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        '$time',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        '$score',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        '$life',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GridView.count(
                  crossAxisCount: 7,
                  children: List.generate(49, (index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            madeWord = madeWord + letters[index + 1];
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          color: Color(0xbfde5757),
                          child: Text(
                            '${letters[index + 1]}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    width: 150,
                    height: 30,
                    margin: EdgeInsets.all(20),
                    child: Text(
                      '$madeWord',
                      style: TextStyle(color: Color(0xffde5757), fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(
                          0xffde5757))),
                      onPressed: () {
                        startTimer();
                        madeWord = "";
                        level = level + 1;
                      },
                      child: Text("Submit")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

