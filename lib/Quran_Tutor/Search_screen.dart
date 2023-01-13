import 'package:flutter/material.dart' ;
import 'package:quran_tutor/Quran_Tutor/Surah_screen.dart' ;
import 'package:quran_tutor/services/api_services.dart' ;
import 'package:quran_tutor/models/Data.dart' ;

import '../Const/Const.dart';
import '../widget/surah_custom.dart'; 

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
  List VersesSearch = [] ;
  ApiService apiService = ApiService();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {}, icon: Icon(Icons.close)),
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
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
              future: apiService.getSearched(), 
              builder: (BuildContext context,
                         AsyncSnapshot<List<SearchVerse>> snapshot) {
                          
                        if (snapshot.hasData) {
                          
                          List<SearchVerse>? SearchV = snapshot.data;

                          return ListView.builder(
                            itemCount: SearchV!.length,
                            itemBuilder: (context, index)=> 
                               Text(SearchV[index].toString()),
                          
                              
                            );
                        }
                        return Center(child: CircularProgressIndicator(),);
                         }
              
              );
  }

}