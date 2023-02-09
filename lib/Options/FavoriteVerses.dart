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
        appBar: AppBar(title: Text("Favorite Verses"),),
        body : surah_screen.Fav.length > 0 ? ListView.builder(
          itemCount: surah_screen.Fav.length ,
          itemBuilder: (context,index) { return Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Center(
                        child: Text(surah_screen.Fav[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                      ),
                      Spacer(),
                      IconButton(icon: Icon(Icons.remove_circle_rounded, color: Colors.red, size: 20,),
                      onPressed: () { setState(() {
                      surah_screen.Fav.removeAt(index);
                });})
                    ],
                  ),
                  Divider(thickness: 2,)
                ],
              ),
            ],
          ); } ) : Center(
          child: Text("There is no favorite Verse",
                  
                 textAlign: TextAlign.center,
                 style : TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      )
      
    );
  }
}