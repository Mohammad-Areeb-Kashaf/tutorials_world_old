import 'package:flutter/material.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/widget/tutorial_card.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackground,
      child: Scaffold(
        body: _showScreen(),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 16.0,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.deepPurple.shade800,
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Colors.deepPurple.shade800,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
              backgroundColor: Colors.deepPurple.shade800,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
              backgroundColor: Colors.deepPurple.shade800,
            ),
          ],
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade600,
          centerTitle: true,
          title: _showTitle(),
        ),
      ),
    );
  }

  Widget _showScreen() {
    if (_currentIndex == 0) {
      return ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          TutorialCard(),
          TutorialCard(),
          TutorialCard(),
          TutorialCard(),
          TutorialCard(),
          TutorialCard(),
          TutorialCard(),
          TutorialCard(),
          TutorialCard(),
          TutorialCard(),
        ],
      );
    } else if (_currentIndex == 1) {
      return Center(
        child: Text('Search Page'),
      );
    } else if (_currentIndex == 2) {
      return Center(
        child: Text('Account Page'),
      );
    } else if (_currentIndex == 3) {
      return Center(
        child: Text('Menu'),
      );
    } else {
      return Center(
        child: Text('Pata Nahi kounsa Page hai???'),
      );
    }
  }

  Widget _showTitle() {
    if (_currentIndex == 0) {
      return Text('Tutorials Wallah');
    } else if (_currentIndex == 1) {
      return Text('');
    } else if (_currentIndex == 2) {
      return Text('');
    } else if (_currentIndex == 3) {
      return Text('');
    } else {
      return Text('');
    }
  }
}
