import 'package:flutter/material.dart';
import 'package:sudachadadmin/screens/login_screen.dart';
import 'package:sudachadadmin/screens/meeting_screen.dart';
import 'package:sudachadadmin/screens/profile_screen.dart';
import 'package:sudachadadmin/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<Widget> _children() {
    return [
      MeetingScreen(
        uid: widget.uid,
      ),
      ProfileScreen(),
      SettingScreen(),
    ];
  }

  final _appBarTitles = ['Rencontres', 'Profile', 'Reglages'];

  @override
  Widget build(BuildContext context) {
    print('The user uid:  ${widget.uid}');
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_currentIndex]),
      ),
      body: _children()[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room),
            label: 'Rencontres',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Reglages',
          ),
        ],
      ),
    );
  }
}
