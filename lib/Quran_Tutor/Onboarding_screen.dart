import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:quran_tutor/Const/Const.dart';
import 'package:quran_tutor/Audio/audio_screen.dart';
import 'package:quran_tutor/Quran_Tutor/Home_Screen.dart';
import 'package:quran_tutor/Quran_Tutor/Quran_screen.dart';
import 'package:quran_tutor/Quran_Tutor/Setting_screen.dart';

import 'Search_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectIndex = 2 ;
  List<Widget> _listWidget = [Setting(),QuranScreen(),HomePage(),AudioScreen(),SearchScreen()] ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _listWidget[selectIndex],
        bottomNavigationBar: BottomNavigationBar(

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.settings,size: 60,), label: 'Setting',),
            BottomNavigationBarItem(icon: Icon(Icons.book,size: 60,), label: 'Quran',),
            BottomNavigationBarItem(icon: Icon(Icons.home,size: 60,), label: 'Home',),
            BottomNavigationBarItem(icon: Icon(Icons.audio_file,size: 60,), label: 'Audio',),
            BottomNavigationBarItem(icon: Icon(Icons.search,size: 60,), label: 'Search',),
                 ],
              
              // onTap: update,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black12,
              
              currentIndex: selectIndex,
              onTap : (index) {
                setState(() {
                  selectIndex = index ;
                });
              },
              
              // activeColor: Const.kPrimary,
        ))
    );
  }
}