import 'package:flutter/material.dart';

class DictionaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
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
          width: 300,
          margin: EdgeInsets.all(20),
          child: TextField(
          decoration: const InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffb4aeae), width: 0.0),
              ),
          border: OutlineInputBorder(),
            hintText: 'Enter any word..',
            hintStyle: TextStyle(color: Color(0xffb4aeae), fontSize: 20)
      ),
            style: TextStyle(color: Colors.white, fontSize: 20),
  ),
        ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(
                    0xffde5757))),
                onPressed: () {
                },
                child: Text("Search")),
          ],
        ),
      ),
    ),
  );
}