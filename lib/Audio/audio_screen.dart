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
    return Scaffold(
      appBar: AppBar(title: Text("Reciter"),centerTitle: true,),
      body: Padding( padding: const EdgeInsets.only(top: 20,left: 12,right: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              },),)],
        ),));
  }}
  