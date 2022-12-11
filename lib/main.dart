import 'package:flutter/material.dart';
import 'package:quran_tutor/Quran_Tutor/surah_screen.dart';
import 'Const/Const.dart';
import 'Quran_Tutor/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Tutor',
      theme: ThemeData(

        primarySwatch: Const.switchColor,
        primaryColor: Const.kPrimary,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins'
      ),
      home: HomePage(),

      routes: {
        surah_screen.id:(context)=>surah_screen()
      },
    );
  }
}
