import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran_tutor/Quran_Tutor/Home_Screen.dart';
import 'package:quran_tutor/Quran_Tutor/Surah_screen.dart';
import 'Const/Const.dart';
import 'Quran_Tutor/Onboarding_screen.dart';

void main() {

  HttpOverrides.global = MyHttpOverrides();
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
      home: HomeScreen(),

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
  }
}

