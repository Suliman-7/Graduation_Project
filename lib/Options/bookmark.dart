import 'package:flutter/material.dart' ;
import 'package:quran_tutor/Quran_Tutor/Surah_screen.dart' ;

import 'package:quran_tutor/models/Data.dart';


class bookmark extends StatefulWidget {
  

  @override
  State<bookmark> createState() => _bookmarkState();
}

class _bookmarkState extends State<bookmark> {
  @override
  
  Widget build(BuildContext context) {
    return SafeArea(
      child : Scaffold (
        appBar: AppBar(),
        body : Column(
          children: [
            Text(surah_screen.BV == '' ? surah_screen.BV : "There is No bookmarked Verse"),
            
          ],
        ),
      )
      
    );
  }
}