
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Quran_Tutor/Verse.dart';



class Versec {
  String? verseClean ;
  
  Versec({this.verseClean});

  factory Versec.fromJSON(Map<String,dynamic> json){
    return Versec(
      verseClean: json['text'],
    );
  }
}

class verseCList {

  final List<Versec> verseList ;

  verseCList({required this.verseList});

  factory verseCList.fromJSON(Map<String,dynamic>MAP){
    Iterable l = MAP['data'][0]['ayahs'];
    List<Versec> list = l.map((e) => Versec.fromJSON(e)).toList();
    print(list);
    
    return verseCList(verseList: list);
  }
  
}



class Surah {

  int? verseNumber ; 
  String? verse ;
  int? QuranNumber ; 
  

  Surah({this.verse,this.verseNumber,this.QuranNumber});

  factory Surah.fromJSON(Map<String,dynamic> json){
    return Surah(
      verseNumber: json['numberInSurah'],
      verse: json['text'],
      QuranNumber: json['numberInSurah']
                 );
}}

class surahList {

  final List<Surah> surahlist ;

  surahList({required this.surahlist});

  factory surahList.fromJSON(Map<String,dynamic>map){
    Iterable l = map['data'][0]['ayahs'];
    List<Surah> list = l.map((e) => Surah.fromJSON(e)).toList();
    print(list);
    
    return surahList(surahlist: list);
  }
  
}


// class verseList {

//   final List<Verse> verselist ;

//   verseList({required this.verselist});

//   factory verseList.fromJSON(Map<String,dynamic>map){
//     Iterable l = map['result'];
//     List<verseList> vlist = l.map((e) => verseList.fromJSON(e)).toList();
//     print(vlist.length);
//     return verseList(verselist: vlist);
//   }
// }


class SurahList {

  int? number;
  String? name;
  String? englishName;
  int? numberOfVerses;
  String? typeOfRevelation;

  SurahList({this.number,this.name, this.englishName,this.numberOfVerses,this.typeOfRevelation});

  factory SurahList.fromJSON(Map<String,dynamic> json){
    return SurahList(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      numberOfVerses: json['numberOfAyahs'],
      typeOfRevelation: json['revelationType']
                 );


  }


}

class verseDay {
  late final String? arText;
  late final String? enTran;
  late final String? surEnName;
  late final int? surNumber;

  verseDay({this.arText,this.enTran,this.surEnName,this.surNumber});

  factory verseDay.fromJSON(Map <String, dynamic> json) {
    return verseDay(
      arText: json['data'][0]['text'],
      enTran: json['data'][2]['text'],
      surEnName: json['data'][2]['surah']['name'],
      surNumber: json['data'][2]['numberInSurah']
    );
  }

}


class Reciter { 
  
  String? name;
  String? path;
  String? format;

  Reciter({this.name,this.path,this.format});

  factory Reciter.fromJSON(Map<String,dynamic> json){
    return Reciter(
      name: json['name'],
      path: json['relative_path'],
      format: json['file_format'],
    );
  }
}
