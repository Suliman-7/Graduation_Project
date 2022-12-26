import 'dart:convert' ;
import 'dart:math';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:quran_tutor/models/Data.dart';
import 'package:http/http.dart' as http ;

import '../models/Data.dart';


class ApiService {

    List<Reciter> ReciterList = [];
    Future<List<Reciter>> getReciterList() async{

      final url = "https://quranicaudio.com/api/qaris" ;
      final res = await http.get(Uri.parse(url));

      jsonDecode(res.body).forEach((Element){
        if(ReciterList.length<10)
        ReciterList.add(Reciter.fromJSON(Element));
      });
      ReciterList.sort((a,b)=>a.name!.compareTo(b.name!));
      return ReciterList;
    }

    
    
    Future <surahList> getverses(int index) async {
      final Url = "https://api.alquran.cloud/v1/surah/${index}/editions/quran-simple" ;
      var res = await http.get(Uri.parse(Url));

      return surahList.fromJSON(json.decode(res.body));
    }



    Future <verseCList> getV(int index) async {
      final Url = "https://api.alquran.cloud/v1/surah/${index}/editions/quran-simple-clean" ;
      var res = await http.get(Uri.parse(Url));

      return verseCList.fromJSON(json.decode(res.body));
    }

    

    final endPointUrl = "http://api.alquran.cloud/v1/surah" ;
    List<SurahList> list = [] ;
    Future <List<SurahList>> getSurah() async {
      Response res = await http.get(Uri.parse(endPointUrl));
      if (res.statusCode == 200 ){
        Map<String,dynamic> json = jsonDecode(res.body);
        json['data'].forEach((element){
          if(list.length<114){
            list.add(SurahList.fromJSON(element));
          }
        });
        print('ol ${list.length}');
        return list;
      }
        else{
          throw("Can't get the Surah");
        }
    }
    
    Future <verseDay> getVerseDay() async {
      String url = "http://api.alquran.cloud/v1/ayah/${random(1,6237)}/editions/quran-simple,en.pickthall";
      final Response = await http.get(Uri.parse(url));

      if (Response.statusCode == 200 ) {
        return verseDay.fromJSON(json.decode(Response.body));
      }
      else {
        print('failed to load');
        throw Exception("Failed to load Post");
      
    }
    }
    random(min,max){
      var rN = new Random();
      return min + rN.nextInt(max-min);
    }}


    