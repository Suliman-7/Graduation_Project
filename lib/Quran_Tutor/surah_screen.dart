
import 'dart:ffi';

import 'package:flutter/material.dart' ;
import 'package:quran_tutor/services/api_services.dart';

import '../Const/Const.dart';
import '../Options/Recite.dart';
import '../models/Data.dart';
import 'Verse.dart'; 



class surah_screen extends StatefulWidget {
  const surah_screen({super.key});

  static const String id = 'surahDetail_screen' ;
  static String BV = '';
  static List Fav = [] ;
  static int QN = 0 ;
  
  

  @override
  State<surah_screen> createState() => _surah_screenState();
}

class _surah_screenState extends State<surah_screen> {

  ApiService apiService = ApiService();

  // var SurTxt = "" ; 
  var Arr = [] ; 


  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: apiService.getverses(Const.surahIndex!),
        builder: (BuildContext context, AsyncSnapshot<surahList> snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.surahlist.length,
              itemBuilder: (context,index){

                var length = (snapshot.data!.surahlist.length-1) ;
                var number =  index ;
                var verse = snapshot.data!.surahlist[index];

                final Ver  = verse.verse;
                String? editeted = "";

                if (number == 0) {
                    Arr.add(' ${verse.verse}   { ${(verse.verseNumber)} } ' );
                    // Arr.add("");                    
                  } else {
                    Arr.add("${verse.verse}   { ${(verse.verseNumber)} }");
                  }

                return TextButton(onPressed: ()
                {
                  var choosedverse = Arr[index];
                  var qn = verse.QuranNumber ;
                  openDialog(choosedverse,qn);
                                // Navigator.pushNamed(context, surah_screen.id);
                               }, 

                    child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color.fromARGB(255, 243, 255, 192),
                    child: Text("${Arr[index]}",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)));
                

                  
                
                

                

                    
                  
                  // return Container(
                  //   padding: EdgeInsets.all(8.0),
                  //   color: Color.fromARGB(255, 243, 255, 192),
                  //   child: Text("${SurTxt}",
                  //   textAlign: TextAlign.right,
                  //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                    
                  //   );
                }
                


              );
              
          }
          
        
          else return Center(child: Text("verse not found"),);
        }),
      
      
    );
  }

Future<void> openDialog(choosedverse, qn) async {
  switch( await showDialog(
    context: context, 
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text("select option"),
        children: [
          SimpleDialogOption(child: Text("Start Reading"),
          onPressed: () {
          surah_screen.QN = qn ;
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){return SpeechText();
          }));},),


          
          SimpleDialogOption(child: Text("Favorite verse"),
          onPressed: () {
            surah_screen.Fav.add(choosedverse);
            
          },),
          SimpleDialogOption(child: Text("Bookmark verse"),
          onPressed: () {
            surah_screen.BV = choosedverse ;
            
          },),
          SimpleDialogOption(child: Text("Share verse"),
          onPressed: () {
            var Sharedverse = choosedverse ;
            print(Sharedverse);
          },),
        ],
      );
    })){
     
    }
}
}