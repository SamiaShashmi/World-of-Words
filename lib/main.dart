import 'package:flutter/material.dart';
import 'package:word_game/pages/dictionary.dart';
import 'package:word_game/pages/home.dart';
import 'package:word_game/pages/play.dart';
import 'package:word_game/widget/navigation_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:word_game/widget/start_pop_up.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World of Words',
      theme: ThemeData(
        primarySwatch: Colors.red,
          fontFamily: "RobotoSlab"
      ),
      home: const MainPage(title: 'World of Words',),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
int currentIndex = 1;
final pages = [StartPopUpPage(), HomePage(), DictionaryPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xffde5757),
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        backgroundColor: Color(0xff363434),
        onTap: (index) => setState(() =>
          currentIndex = index,
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle, ),
              label: 'Play',
              backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, ),
              label: 'Home',
              backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_sharp, ),
              label: 'Dictionary',
              backgroundColor: Colors.white
          )
        ],
      ),

      );

  }
}


