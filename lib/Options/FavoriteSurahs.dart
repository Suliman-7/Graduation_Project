
import 'package:flutter/material.dart' ;
import 'package:quran_tutor/widget/surah_custom.dart' ;
import 'package:quran_tutor/Quran_Tutor/Surah_screen.dart' ;

import '../Const/Const.dart';


class FavoriteSurahs extends StatefulWidget {
  const FavoriteSurahs({super.key});

  @override
  State<FavoriteSurahs> createState() => _FavoriteSurahsState();
}

class _FavoriteSurahsState extends State<FavoriteSurahs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child : Scaffold (
        appBar: AppBar(),
        body : ListView.builder(
        itemCount: SurahL.FavSur.length ,
          itemBuilder: (context,index) { return Column(
            children: [

            TextButton(child: Text(SurahL.FavSur[index]),
            onPressed: () { setState(() {
            Const.surahIndex = SurahL.FavSurNum[index] ; 
            Navigator.pushReplacementNamed(context, surah_screen.id);
            }); 
            })
            ],
          ); } ),
      )
      
    );
  }
}