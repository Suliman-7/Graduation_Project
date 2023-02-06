import 'package:flutter/material.dart' ;
import 'package:quran_tutor/Quran_Tutor/Surah_screen.dart';


class FavoriteVerses extends StatefulWidget {
  const FavoriteVerses({super.key});

  @override
  State<FavoriteVerses> createState() => _FavoriteVersesState();
}

class _FavoriteVersesState extends State<FavoriteVerses> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child : Scaffold (
        appBar: AppBar(),
        body : surah_screen.Fav.length > 0 ? ListView.builder(
          itemCount: surah_screen.Fav.length ,
          itemBuilder: (context,index) { return Column(
            children: [
              Text(surah_screen.Fav[index]),
            ],
          ); } ) : Text("There is no favorite Verse"),
      )
      
    );
  }
}