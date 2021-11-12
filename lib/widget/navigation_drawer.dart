import 'dart:io';

import 'package:flutter/material.dart';
import 'package:word_game/pages/dictionary.dart';
import 'package:word_game/pages/instruction.dart';
import 'package:word_game/pages/play.dart';
import 'package:word_game/widget/start_pop_up.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color(0xff2d2b2b),
        child: ListView(
          padding: padding,
          children: <Widget>[

            const SizedBox(height: 48),
            buildMenuItem(
                text: "Instructions",
                icon: Icons.live_help,
                onClicked: () => selectedItem(context, 2)
            ),
            const SizedBox(height: 24),
            Divider(color: Colors.white70,),
            const SizedBox(height: 24),
            buildMenuItem(
                text: "Exit",
                icon: Icons.logout,
                onClicked: () => selectedItem(context, 3)
            )
          ],
        ),
      )
    );
  }

  Widget buildMenuItem({required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.white;
    final hoverColor = Color(0xffde5757);

    return ListTile(
      leading: Icon(icon, color: color,),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StartPopUpPage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DictionaryPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InstructionPage(),
        ));
        break;
      case 3:
        exit(0);
    }
  }
}