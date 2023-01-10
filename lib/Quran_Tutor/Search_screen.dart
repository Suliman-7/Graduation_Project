import 'package:flutter/material.dart' ; 

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
    return Text("محتوى البحث");
  }

}