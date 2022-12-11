import 'package:flutter/material.dart';
import 'package:quran_tutor/Const/Const.dart';
import 'package:quran_tutor/Quran_Tutor/surah_screen.dart';
import 'package:quran_tutor/services/api_services.dart';

import '../models/Data.dart';
import '../widget/surah_custom.dart';


class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      initialIndex: 0,
      child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text("Quran"),
            centerTitle: true,
            backgroundColor: Colors.black54,
            bottom: TabBar(
                          indicatorColor: Color.fromARGB(255, 249, 214, 107) ,  
                          tabs: [ 
                                  
                            Text("Surah List",
                            style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                            ),),
                          ],
                          ),
                      ),
        
        body: TabBarView(
          children: <Widget> [
            FutureBuilder(
              future: apiService.getSurah(),
              builder: (BuildContext context,
                         AsyncSnapshot<List<SurahList>> snapshot) {
                          
                        if (snapshot.hasData) {
                          List<SurahList>? surah = snapshot.data;

                          return ListView.builder(
                            itemCount: surah!.length,
                            itemBuilder: (context, index)=> surahCustomListTile(surah: surah[index],
                               context: context, ontap : () {
                                setState(() {
                                  Const.surahIndex = (index + 1);
                                });
                                Navigator.pushNamed(context, surah_screen.id);
                               } ),
                              
                            );
                        }
                        return Center(child: CircularProgressIndicator(),);
                         }
              
              ),

          ],
        ),
      ),
    ));
  }
}