import 'package:flutter/material.dart' ;
import 'package:http/http.dart';
import 'package:quran_tutor/Quran_Tutor/Surah_screen.dart' ;
import 'package:quran_tutor/services/api_services.dart' ;
import 'package:quran_tutor/models/Data.dart' ;
import 'package:http/http.dart' as http ;
import '../Const/Const.dart';
import '../widget/surah_custom.dart'; 
import 'dart:convert' ;
import 'dart:math';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(actions: [IconButton(icon: Icon(Icons.search),onPressed: (){
        showSearch(context: context, delegate: DataSearch());
      },)]),
      body : Container(
      alignment: Alignment.center,
      child: Text("Search"),
      ));
    
  }
}

class DataSearch extends SearchDelegate {
  List<SearchVerse> VersesSearch = [] ;
  ApiService apiService = ApiService();
  
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {query = '' ;}, icon: Icon(Icons.close)),
    ] ;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return null! ;
  }

  @override
    List<SearchVerse> VSList = [] ;
    Future <List<SearchVerse>> getSearched() async {
      int index = 0 ; 
      final endPointUrl = "https://api.alquran.cloud/v1/search/${query}/all/quran-simple-clean" ;
      Response res = await http.get(Uri.parse(endPointUrl));
      if (res.statusCode == 200 ){
        Map<String,dynamic> json = jsonDecode(res.body);
        json['data'].forEach((element){

          if(VSList.length<6237){
            VSList.add(SearchVerse.fromJSON(element));
            print(VSList[element]);
            index++;
          }

        });
        return VSList;
      }
        else{
          throw("Can't get the Surah");
        }
    }
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
                            itemCount: VSList.length,
                            itemBuilder: (context, index)=> 
                               Text(VSList[index].toString()),
                          
                              
                            );
                        }
                        
                         }
              
              