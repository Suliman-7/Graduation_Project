
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class SearchVerse{

  String? searchverse  ;
  
  SearchVerse({this.searchverse});

  factory SearchVerse.fromJSON(Map<String,dynamic> json){
    return SearchVerse(
      searchverse : json['matches']['text'],
    );
  }
}

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
    
    return surahList(surahlist: list);
  }
  
}



class SurahData {

  int? number /* 0 */ ;
  String? name /* Alfatiha */ ;
  String? englishName;
  int? numberOfVerses;
  String? typeOfRevelation;

  SurahData({this.number,this.name, this.englishName,this.numberOfVerses,this.typeOfRevelation});

  factory SurahData.fromJSON(Map<String,dynamic> S){
    return SurahData(
      number: S['number'],
      name: S['name'],
      englishName: S['englishName'],
      numberOfVerses: S['numberOfAyahs'],
      typeOfRevelation: S['revelationType']
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
      enTran: json['data'][1]['text'],
      surEnName: json['data'][0]['surah']['name'],
      surNumber: json['data'][0]['numberInSurah']
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
