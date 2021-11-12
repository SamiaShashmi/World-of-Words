import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Color(0xff000000)),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(50),
                  child: Image.network(
                      'https://thumbs.dreamstime.com/b/back-to-school-important-words-business-world-cloud-words-illustration-black-white-school-word-cloud-background-back-160388225.jpg')),
              Text('Tour the ', style: TextStyle(color: Color(0xffde5757), fontSize: 25),),
              const SizedBox(
                height: 20,
              ),
              Text('World of Words', style: TextStyle(color: Colors.white, fontSize: 30, fontStyle: FontStyle.italic),)
            ],

          ),

        ),
      );
}
