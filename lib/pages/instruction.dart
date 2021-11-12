import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Instructions'),
      centerTitle: true,
      backgroundColor: Colors.red,
    ),
    body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(color: Color(0xff000000)),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Color(0xffde5757)),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                child: Text('You will be given a 7 x 7 grid of random letters. You will get 15 seconds to make a valid word.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Color(0xffde5757)),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                child: Text('After making a word, press the submit button to verify. You will get the result instantly with the definition of the made word.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Color(0xffde5757)),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                child: Text('You will have only three lives. You will lose one life if you can not make a word within given time or if you make an invalid word..',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Color(0xffde5757)),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                child: Text('If you are able to make a valid word, then you will get score according to the number of letters of that word. Then you can go to the next level.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Color(0xffde5757)),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                child: Text('If you want to know about any word, you can use the dictionary. Here you will find the Definition, Pronunciation, Parts of Speech as well as an Example.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),

            ],
          ),
        ),
      ),

    ),
  );
}