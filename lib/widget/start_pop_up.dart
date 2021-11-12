import 'package:flutter/material.dart';
import 'package:word_game/pages/play.dart';

class StartPopUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      backgroundColor: Color(0xff2a2828),
      actionsAlignment: MainAxisAlignment.center,
      scrollable: true,
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xffde5757))),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlayPage()));
            },
            child: const Text("Start")
        ),
      ],
    );
  }
}