import 'dart:io';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
  int selectIndex = 1;
  List<Widget> _listWidget = [QuranScreen(),HomePage(),AudioScreen()] ;
  
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
          backgroundColor : Color.fromARGB(221, 237, 231, 231) ,
          selectedItemColor : Color.fromARGB(255, 23, 66, 87),
          selectedFontSize: 15,
          unselectedItemColor : Color.fromARGB(255, 125, 132, 133), 
          

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.book_rounded,size: 50,), label: 'Quran'),
            BottomNavigationBarItem(icon: Icon(Icons.home,size: 50,), label: 'Home',),
            BottomNavigationBarItem(icon: Icon(Icons.audio_file,size: 50,), label: 'Audio',),
                 ],
              
              // onTap: update,

              
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