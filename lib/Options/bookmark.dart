import 'package:flutter/material.dart' ;
import 'package:quran_tutor/Quran_Tutor/surah_screen.dart' ;


class bookmark extends StatefulWidget {
  const bookmark({super.key});

  @override
  State<bookmark> createState() => _bookmarkState();
}

class _bookmarkState extends State<bookmark> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child : Scaffold (
        appBar: AppBar(),
        body : Text(surah_screen.BV),
      )
      
    );
  }
}