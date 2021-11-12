import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:word_game/classes/word.dart';
import 'package:word_game/pages/home.dart';

import '../main.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  int time = 15;
  int score = 0;
  int life = 3;
  int level = 1;
  String madeWord = "";
  String alphabet = "abcdefghijklmnopqrstuvwxyz";
  late List<String> letters = [""];
  Timer? timer;
  String strResponse = "";
  late Welcome welcome;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time == 0) {
          setState(() {
            timer.cancel();
            life = life - 1;
            if(life == 0)
              {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialogOver(context),
                );
                setState(() {
                  generateRandomLetter();
                  time = 15;
                  madeWord = "";
                  life = 3;
                });
              }
            else
              {
                generateRandomLetter();
                madeWord = "";
                level = level + 1;
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialogFail(context),
                );
              }

          });
        } else {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  void generateRandomLetter() {
    Random r = new Random();
    letters = [""];
    for (int i = 0; i < 49; i++) {
      setState(() {
        letters.add(alphabet[r.nextInt(alphabet.length)]);
      });

    }
  }

  void verifyWord(String madeWord) async {
    http.Response res = await http.get(Uri.parse(
        'https://api.dictionaryapi.dev/api/v2/entries/en/' + '$madeWord'));
    if (res.statusCode == 200) {
      welcome = Welcome.fromJson(jsonDecode(res.body)[0]);
      if(welcome.word!.length == 1 && welcome.word != 'i' && welcome.word != 'a')
        {
          setState(() {
            life = life - 1;
            if(life == 0)
            {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialogOver(context),
              );
              setState(() {
                generateRandomLetter();
                time = 15;
                madeWord = "";
                life = 3;
              });
            }
            else
              {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialogFail(context),
                );
              }
          });


        }
      else
        {
          setState(() {
            score = score + welcome.word!.length;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        }

    }
    else {
      setState(() {
        life = life - 1;
        if(life == 0)
        {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialogOver(context),
          );
          setState(() {
            generateRandomLetter();
            time = 15;
            madeWord = "";
            life = 3;
          });
        }
        else
          {
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialogFail(context),
            );
          }
      });

      throw Exception('Failed to load album');
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('${welcome.word}', textAlign: TextAlign.center, style: TextStyle(color: Color(0xffde5757), fontWeight: FontWeight.bold, fontSize: 25),),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('${welcome.meanings![0].definitions![0].definition}', textAlign: TextAlign.center,),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              time = 15;
              startTimer();
              generateRandomLetter();
            });

          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Next'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).push (MaterialPageRoute(
                builder: (context) => MyApp()));

          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Exit'),
        ),
      ],
    );
  }

  Widget _buildPopupDialogFail(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Sorry, no word found..', textAlign: TextAlign.center, style: TextStyle(color: Color(0xffde5757), fontWeight: FontWeight.bold, fontSize: 25),),

      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              time = 15;
              startTimer();
              generateRandomLetter();
            });
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _buildPopupDialogOver(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Game Over!!', textAlign: TextAlign.center, style: TextStyle(color: Color(0xffde5757), fontWeight: FontWeight.bold, fontSize: 25),),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Total score: $score', textAlign: TextAlign.center, ),
          Text('Total level passed: $level', textAlign: TextAlign.center,)
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).push (MaterialPageRoute(
                builder: (context) => MyApp()));

          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    generateRandomLetter();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff2a2828),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
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
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffde5757))),
                      onPressed: () {
                        timer!.cancel();
                        setState(() {
                          verifyWord(madeWord);
                          madeWord = "";
                          level = level + 1;
                        });
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
