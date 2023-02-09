
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:quran_tutor/Options/FavoriteSurahs.dart';
import 'package:quran_tutor/Options/FavoriteVerses.dart';
import 'package:quran_tutor/models/Data.dart';
import 'package:quran_tutor/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Options/FavoriteVerses.dart';
import '../Options/Bookmark.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  ApiService _apiService = ApiService();

    void setdata()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("alreadyUsed",true);
  }

  void initState(){
    super.initState();
    setdata();
  }


  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var _hijri1 = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat('EEE : d MMM yyyy');
    var formatted = format.format(day);

    // _apiService.getVerseDay().then((value)=>data = value) ;
    return SafeArea(
      
      child: Scaffold(
          appBar: AppBar(
            title: Text("Home Page"),
            centerTitle: true,
          ),
          body: Container(
            
            child: Column(
        children: [


            Container(
              width: double.infinity,
              
              child: Row(

                children: [
                  Container( alignment: Alignment.topLeft,
                    child: Text(
                      formatted,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Spacer(),
                  Container( alignment: Alignment.topRight,
                    child: RichText(
                        
                        text: TextSpan(children: <InlineSpan>[
                      WidgetSpan(
                        style: TextStyle(fontSize: 20),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            _hijri1.hDay.toString(),
                            style: TextStyle(fontSize: 20,),
                          ),
                        ),
                      ),
                      WidgetSpan(
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(_hijri1.longMonthName,
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      WidgetSpan(
                          style: TextStyle(fontSize: 20),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(_hijri1.hYear.toString(),
                                  style: TextStyle(
                                      fontSize: 20))))
                    ])),
                  )
                ],
              ),
            ),
            Expanded(child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 10,bottom: 20),
              child:
                  FutureBuilder <verseDay> (
              future: _apiService.getVerseDay(),
              builder: ((context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none :
                    return Icon(Icons.sync_problem);
                  case ConnectionState.waiting :
                  case ConnectionState.active :
                    return CircularProgressIndicator();
                  case ConnectionState.done :
                    return Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 165, 165, 165),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                      BoxShadow(
                       blurRadius:3,
                       spreadRadius:1,
                       offset : Offset(0,1)
                    )]),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        
                        children: [
                        Text("Verse of the day" , 
                        style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),), 
                        Divider(thickness: 2,),
                        Text(snapshot.data!.arText!, style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        Text(snapshot.data!.enTran!, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding (padding : EdgeInsets.all(8),
                              child: Text(snapshot.data!.surNumber.toString(),
                              style: TextStyle(fontSize: 16),)),

                            Padding (padding : EdgeInsets.all(8),
                                child: Text(snapshot.data!.surEnName!,
                                style: TextStyle(fontSize: 16),))
                          ]
                        )
                      ],),
                    ) 
                  );
              }})),
            )),

            Center(
              child: Row(
                children: [
                  Column(children: [
                    Container(child: IconButton(icon: Icon(Icons.bookmark,size: 35,), onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context){return bookmark();}));
                      },)),
                    Container(child: Text("Bookmark \n" , textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)
                  ]),
                  Spacer(),
                  Column(children: [
                    Container(child: IconButton(icon: Icon(Icons.list,size: 35,), onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context){return FavoriteSurahs();}));
                      },)),
                    Container(child: Text("Favorite \n Surahs" , textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)
                  ]),
                  Spacer(),
                  Column(children: [
                    Container(child: IconButton(icon: Icon(Icons.star,size: 35,), onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context){return FavoriteVerses();}));
                      },)),
                    Container(child: Text("Favorite \n Verses" , textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)
                  ]),
                  Spacer(),
                  Column(children: [
                    Container(child: IconButton(icon: Icon(Icons.search,size: 35,), onPressed: () {
                    showSearch(context: context, delegate: DataSearch());
                      },)),
                    Container(child: Text("Search \n" , textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)
                  ]),
                ],
              ))
        ],
      ),
          )),
    );
  }
}

class DataSearch extends SearchDelegate {
  List<SearchVerse> VersesSearch = [] ;
  ApiService apiService = ApiService();
  
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {query = '';}, icon: Icon(Icons.close)),
    ] ;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {close(context, null);}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return null! ;
  }

  @override
  List<SearchVerse> VSList = [] ;
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
              future: apiService.getSearched(), 
              builder: (BuildContext context,
                         AsyncSnapshot<List<SearchVerse>> snapshot) {
                          
                        if (snapshot.hasData) {
                          
                          List<SearchVerse>? SearchV = snapshot.data;
                          List SV = [] ;
                          for (int i=0 ; i<SearchV!.length ; i++){
                           SV.add(SearchV[i].searchverse);
                          }
                          

                          List FSV = SV.where((element) => element.toString().contains(query)).toList();




                          return ListView.builder(
                            itemCount: FSV.length ,
                            itemBuilder: (context, i) {
                            
                            return Column(
                              children: [
                                Center(
                                  child: Text(
                                      query == "" ? "" : "${FSV[i]}" ,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),
                                    ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(thickness: 3,))
                              ],
                            );
                        });
                        }
                        return Center(child: CircularProgressIndicator(),);
                         }
              
              );
  }

}
