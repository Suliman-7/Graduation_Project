import 'package:flutter/material.dart' ;
import 'package:quran_tutor/Quran_Tutor/surah_screen.dart' ;

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child : Scaffold (
        appBar: AppBar(),
        body : ListView.builder(
        itemCount: surah_screen.Fav.length ,
          itemBuilder: (context,index) { return Text(surah_screen.Fav[index]); } ),
      )
      
    );
  }
}