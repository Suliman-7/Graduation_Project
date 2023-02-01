import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran_tutor/Quran_Tutor/Home_Screen.dart';
import 'package:quran_tutor/Quran_Tutor/Surah_screen.dart';
import 'Audio/audio_screen.dart';
import 'Const/Const.dart';
import 'Quran_Tutor/Quran_screen.dart';
import 'Quran_Tutor/Search_screen.dart';
import 'Quran_Tutor/Setting_screen.dart' ;

bool _IconBool = false ; 

IconData IconLight = Icons.wb_sunny ;
IconData IconDark = Icons.dark_mode ;

ThemeData _lightTheme = ThemeData(
  primarySwatch: Colors.blueGrey ,
  brightness: Brightness.light ,
);

ThemeData _darkTheme = ThemeData(
  primarySwatch: Colors.indigo ,
  brightness: Brightness.dark ,
);

void main() {

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());

  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectIndex = 2 ;
  List<Widget> _listWidget = [Setting(),QuranScreen(),HomePage(),AudioScreen(),SearchScreen()] ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Tutor',
      theme: _IconBool ? _lightTheme : _darkTheme ,
      home: Scaffold(
        appBar: AppBar(
        
        actions: [
          IconButton(onPressed:(){
            setState(() {
              _IconBool = !_IconBool ;
            });
          },
          icon: Icon(_IconBool ? IconDark : IconLight ),
          )
        ]),
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
        )),
    
      routes: {
        surah_screen.id:(context)=>surah_screen()
      },
    );
  }
  }


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true ;
  }}