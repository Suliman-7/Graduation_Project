
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:quran_tutor/Options/Favorites.dart';
import 'package:quran_tutor/models/Data.dart';
import 'package:quran_tutor/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Options/Favorites.dart';
import '../Options/bookmark.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {



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
            backgroundColor: Colors.black54,
            centerTitle: true,
          ),
          body: Container(
            
            child: Column(
        children: [


            Container(
              width: double.infinity,
              
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( alignment: Alignment.topLeft,
                    child: Text(
                      formatted,
                      style: TextStyle(color: Colors.black, fontSize: 20),
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
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                      WidgetSpan(
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(_hijri1.longMonthName,
                              style: TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                      ),
                      WidgetSpan(
                          style: TextStyle(fontSize: 20),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(_hijri1.hYear.toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black))))
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
                      padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      
                      // borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                      boxShadow: [
                      BoxShadow(
                       blurRadius:3,
                       spreadRadius:1,
                       offset : Offset(0,1)
                    )]),
                    child: Container(
                      color: Colors.blueGrey,
                      child: Column(
                        
                        children: [
                        Text("Verse of the day" , 
                        style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold , fontSize: 20),), 
                        Divider(color : Colors.black ,  thickness: 1 ,),
                        Text(snapshot.data!.arText!, style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        Text(snapshot.data!.enTran!, style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
                    Container(child: IconButton(icon: Icon(Icons.bookmark), onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context){return bookmark();}));
                      },)),
                    Container(child: Text("Bookmark" , textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)
                  ]),
                  Spacer(),
                  Column(children: [
                    Container(child: IconButton(icon: Icon(Icons.star), onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context){return Favorites();}));
                      },)),
                    Container(child: Text("Favorite Surah" , textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)
                  ]),
                  Spacer(),
                  Column(children: [
                    Container(child: IconButton(icon: Icon(Icons.star), onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context){return Favorites();}));
                      },)),
                    Container(child: Text("Favorites Verse" , textAlign: TextAlign.center, 
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
