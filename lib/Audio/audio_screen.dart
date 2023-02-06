import 'package:flutter/material.dart';
import 'package:quran_tutor/models/Data.dart';
import 'package:quran_tutor/services/api_services.dart';

import '../Quran_Tutor/ReciterScreen.dart';
import 'AudioReciterScreen.dart' ;
import 'audiosurahscreen.dart' ;


class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {

  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(title: Text("Reciter"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,left: 12,right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.white,
                boxShadow: [ BoxShadow(
                  color: Colors.black54,
                  blurRadius: 1,
                  spreadRadius: 0.0,
                  offset: Offset(0, 1)
                )]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("search"),
                      Spacer(),
                      Icon(Icons.search)
                    ],
                  ),),
            ),
            
            SizedBox(height: 12,),
            Expanded(
              child: FutureBuilder(
                future: apiService.getReciterList(),
                builder: (BuildContext context , AsyncSnapshot<List<Reciter>> snapshot ){
                  if (snapshot.hasError){
                    return Center(child: Text("Reciter data not found"),);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      return ReciterScreen(reciter : snapshot.data![index] , ontap : () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=>
                          AudioSurahScreen(reciter: snapshot.data![index])
                        ));
                      });
                    }));
                },
            ),
        )],
        ),)),
    );
  }
}