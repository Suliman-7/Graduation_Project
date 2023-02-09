// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart' ;
import 'package:quran_tutor/Quran_Tutor/Surah_screen.dart' ;

import 'package:quran_tutor/models/Data.dart';


class bookmark extends StatefulWidget {
  

  @override
  State<bookmark> createState() => _bookmarkState();
}

// ignore: camel_case_types
class _bookmarkState extends State<bookmark> {
  @override
  
  Widget build(BuildContext context) {
    return SafeArea(
      child : Scaffold (
        appBar: AppBar(title: Text("Bookmark"),),
        body : surah_screen.BV == '' ? Center(
          child: Text("There is no bookmarked Verse",    
                 textAlign: TextAlign.center,
                 style : TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ) : Center(
                 child: Text( surah_screen.BV ,
                 textAlign: TextAlign.center,
                 style : TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
               )
            )
    );
  }
}


