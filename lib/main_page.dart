import 'package:corona_project/widgets/Youtube.dart';
import 'package:flutter/material.dart';
import 'widgets/ArticlePage.dart';
import 'widgets/Statement.dart';
import 'widgets/Hero.dart';
import 'widgets/Youtube.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Statement(),
    ArticlePage(),
    HeroPage(),
    Youtube(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey[900],
        selectedItemColor: Colors.pinkAccent[400],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/home_selected.png",
              iconPath: "assets/home.png",
              iconName: "코로나 현황"),
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/search_selected.png",
              iconPath: "assets/search.png",
              iconName: "최근뉴스"),
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/heart_selected.png",
              iconPath: "assets/heart.png",
              iconName: "코로나 영웅들"),
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/profile_selected.png",
              iconPath: "assets/profile.png",
              iconName: "유튜브 영상"),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {String activeIconPath, String iconPath, String iconName}) {
    return BottomNavigationBarItem(
      activeIcon:
      activeIconPath == null ? null : ImageIcon(AssetImage(activeIconPath)),
      icon: ImageIcon(AssetImage(iconPath)),
      title: Text(
        iconName,
        style: TextStyle(fontFamily: 'NanumGothic', height: 2.0),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


}

