import 'dart:ffi';
import 'package:flutter/material.dart' ;
import 'package:quran_tutor/Options/Bookmark.dart';
import 'package:quran_tutor/Options/FavoriteVerses.dart';
import 'package:quran_tutor/services/api_services.dart';
import '../Const/Const.dart';
import '../Options/Recite.dart';
import '../models/Data.dart';


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
 
  var Arr = [] ; 
  var qn = ''; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Text(Const.SurahName.toString(),),
            centerTitle: true,
            backgroundColor: Colors.black54,),

      

      // floatingActionButtonLocation : FloatingActionButtonLocation.endFloat,
      floatingActionButton : Padding(
        padding: const EdgeInsets.only(left : 30.0),
        child: Row(
          children: [
            IconButton(icon : Icon(Icons.arrow_left),
            onPressed: () {
            if (Const.surahIndex! > 1) {
            setState(() {
            Const.surahIndex = (Const.surahIndex! - 1) ; 
            Navigator.pushReplacementNamed(context, surah_screen.id);
            });}}),

            Spacer(),

            IconButton(icon : Icon(Icons.arrow_right),
            onPressed: () {
            if (Const.surahIndex! < 114) {
            setState(() {
            Const.surahIndex = (Const.surahIndex! + 1) ; 
            Navigator.pushReplacementNamed(context, surah_screen.id);
            });
            }}),
            

    ]),
      ),

      

      body: FutureBuilder(
            future: apiService.getverses(Const.surahIndex!),
            builder: (BuildContext context, AsyncSnapshot<surahList> snapshot) {

              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              else if (snapshot.hasData){

                
                return ListView.builder(
                    itemCount: (snapshot.data!.surahlist.length)+1 ,
                    itemBuilder: (context,index){

                      var length = (snapshot.data!.surahlist.length-1);
                      var number =  index ;

                      

                      if ((length+1) != index){
                      var verse = (snapshot.data!.surahlist[index]); ;
                      
                      qn = verse.QuranNumber.toString();
                      
                      if (number == 0) {
                          Arr.add("");
                          Arr.add(' ﴾${verse.verse}﴿ ${(verse.verseNumber)} ' );                   
                        } else {
                          Arr.add(" ﴾${verse.verse}﴿ ${(verse.verseNumber)} ");
                        }
                      }


                      if (Const.surahIndex != 1) {
                      Arr[1] = Arr[1].toString().replaceAll('بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ' , '');
                      }

                      if (index==0 && Const.surahIndex != 1){
                        return Text(
                          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20,color: Colors.black54,fontWeight: FontWeight.bold),);
                      }
                      else if (index==0 && Const.surahIndex == 1){
                        return Text("");
                      }
                      else {
                      return TextButton(
                        
                      onPressed: () {

                        var choosedverse = Arr[index];
                        openDialog(choosedverse);
                                      
                        }, 

                          child: Container(
                          padding: EdgeInsets.all(8.0),
                          color: Color.fromARGB(255, 117, 123, 120),
                          child: Text("${Arr[index]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black87),)));
                      }},);
                        }      
                    else return Center(child: Text("verse not found"),);
                  }));
  }



Future<void> openDialog(choosedverse) async {
  switch( await showDialog(
    context: context, 
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text("select option"),
        children: [

          SimpleDialogOption(child: Text("Start Reading"),
          onPressed: () {
          surah_screen.QN = (int.tryParse(qn)!) ;
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){return SpeechText();
          }));},),


          SimpleDialogOption(child: Text("Favorite verse"),
          onPressed: () {
            surah_screen.Fav.add(choosedverse);
          },),

          SimpleDialogOption(child: Text("Bookmark verse"),
          onPressed: () {
          surah_screen.BV = choosedverse ; 
          // Navigator.push(context,MaterialPageRoute(builder: (context){return bookmark();}));
          },),

          SimpleDialogOption(child: Text("Share verse"),
          onPressed: () {
            var Sharedverse = choosedverse ;
            print(Sharedverse);
          },),
        ],
      );
    })){}}}