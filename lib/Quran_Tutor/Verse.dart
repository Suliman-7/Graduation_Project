import 'package:flutter/material.dart' ; 
import 'package:quran_tutor/Const/Const.dart' ; 
import 'package:quran_tutor/models/Data.dart' ;
import 'surah_screen.dart';


class Verse extends StatelessWidget {

  final int number ; 
  final Surah verse ;
  List Verses = [] ;
  Verse({required this.number,required this.verse});

  @override
  Widget build(BuildContext context) {
     
    final Ver  = verse.verse;
    String? editeted = "";

      if (number == 0) {
        Verses.add('بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ');
        Verses.add(verse.verse);
      } else {
        Verses.add(verse.verse);
      }


     return Container(child : Text("${Verses}"));

     
  }

    // return
    // Container(child: 
    // Stack(children: [
      
    //   Text("${verse.verse!} ${verse.verseNumber}",textAlign: TextAlign.right,style: TextStyle (color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)

    // ],),);
              
                //   decoration: BoxDecoration(
                //     color: Const.kPrimary,
                //     borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))
                //   ),
                //   padding: EdgeInsets.all(16),
                //   width: double.infinity,
                // ),
                // Positioned(
                //   top: 3,
                //   left: 12,
                //   child: Container(
                //     padding: EdgeInsets.all(6),
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Colors.black
                //     ),
                //     child: Text(verse.verse! , style: 
                //     TextStyle(color: Colors.white,fontSize: 16),),
                  // ))
              
            
            // Container(
            //   padding: EdgeInsets.all(8),
            //   child: Column(),
            // )

    
  }
