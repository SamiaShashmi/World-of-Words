import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:word_game/classes/word.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  TextEditingController myController = new TextEditingController();
  bool isFound = false;
  bool isSearched = false;
  late Welcome welcome;

  Future<void> searchWord(String findWord) async {
    http.Response res = await http.get(Uri.parse(
        'https://api.dictionaryapi.dev/api/v2/entries/en/' + '$findWord'));
    if (res.statusCode == 200) {
      setState(() {
        welcome = Welcome.fromJson(jsonDecode(res.body)[0]);
        isFound = true;
      });
    } else {
      setState(() {
        isSearched = true;
        isFound = false;
      });

      Fluttertoast.showToast(
          msg: "Sorry, No Word Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  AudioPlayer audioPlayer = AudioPlayer();
  play(String? url) async {
    await audioPlayer.play(
      url!,
      isLocal: false,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xff2a2828),
            ),
            child: Column(
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.all(20),
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffb4aeae), width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Enter any word..',
                        hintStyle:
                            TextStyle(color: Color(0xffb4aeae), fontSize: 18)),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xffde5757))),
                    onPressed: () {
                      searchWord(myController.text);
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Text("Search")),
                const SizedBox(
                  height: 20,
                ),
                isFound
                    ? Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${welcome.meanings![0].definitions![0].definition}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            GestureDetector(
                                onTap: () {
                                  play('https:${welcome.phonetics![0].audio}');
                                },
                                child: Icon(
                                  Icons.volume_up,
                                  size: 40,
                                  color: Color(0xffde5757),
                                )),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                                color: Color(0xffde5757),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '${welcome.meanings![0].partOfSpeech}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )),
                            const SizedBox(
                              height: 22,
                            ),
                            Text(
                              'Example: ${welcome.meanings![0].definitions![0].example}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )
                    :
                Container()
              ],
            ),
          ),
        ),
      );
}
