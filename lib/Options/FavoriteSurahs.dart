import 'package:flutter/material.dart' ;
import 'package:quran_tutor/widget/surah_custom.dart' ;
import 'package:quran_tutor/Quran_Tutor/Surah_screen.dart' ;
import 'package:quran_tutor/models/Data.dart';


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
        appBar: AppBar(title: Text("Favorite Surahs"),),
        body : SurahL.FavSur.length>0 ? ListView.builder(
        itemCount: SurahL.FavSur.length ,
          itemBuilder: (context,index) { return Column(
            children: [

            Row(
              children: [
                  TextButton(child: 
                  Text(SurahL.FavSur[index],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  onPressed: () { setState(() {
                  Const.surahIndex = SurahL.FavSurNum[index] ; 
                  Navigator.pushReplacementNamed(context, surah_screen.id);
                  }); 
                  }),
                Spacer(),
                IconButton(icon: Icon(Icons.remove_circle_rounded, color: Colors.red, size: 20,),
                onPressed: () { setState(() {
                  SurahL.FavSur.removeAt(index);
                });})
              ],
            )
            ],
          ); } ) : Center(
          child: Text("There is no favorite Surah",
                  
                 textAlign: TextAlign.center,
                 style : TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      )
      
    );
  }
}