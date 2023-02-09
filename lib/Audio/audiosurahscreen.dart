import 'package:flutter/material.dart';
import 'package:quran_tutor/models/Data.dart';
import 'package:quran_tutor/services/api_services.dart';
import 'AudioReciterScreen.dart';
import 'audio_screen.dart';

class AudioSurahScreen extends StatefulWidget {
  const AudioSurahScreen({Key? key , required this.reciter }) : super(key:key);

  final Reciter reciter ;

  @override
  State<AudioSurahScreen> createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {

  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 71, 88),
        elevation: 0,
        title: Text('Surah List' , style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: FutureBuilder(
        future: apiService.getSurah(),
        builder: (BuildContext context , AsyncSnapshot<List<SurahData>> snapshot ){

          if (snapshot.hasData){
            List<SurahData>? surah = snapshot.data;
            return ListView.builder(
              itemCount: surah!.length,
              itemBuilder: ((context, index) => 
              AudioTile(
                surEngName : snapshot.data![index].englishName,
                surahName:snapshot.data![index].name,
                TotalVerses: snapshot.data![index].numberOfVerses,
                number: snapshot.data![index].number,

                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AudioReciterScreen(
                    
                    reciter : widget.reciter,
                    index : index+1, 
                    list : surah,
                    )));
                }    
                )));
          }
          return Center(child: CircularProgressIndicator(),);
        }
      ),
    )); 
  }
}


Widget AudioTile ({required String? surEngName , required String? surahName, required TotalVerses, required number, required VoidCallback onTap}){

  return GestureDetector(
    onTap: onTap,
    child: Padding(padding: const EdgeInsets.all(4.0),
    
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        boxShadow: [BoxShadow(
           blurRadius: 1,
           spreadRadius: 0,
           color: Colors.black12,
           offset: Offset(0, 3)
        )]
      ),


      child: Row(children: [
        Container(
          alignment: Alignment.center,
          height: 30,
          width: 40,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black
          ),
          child:Text((number).toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),) ,
        ),
        SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(surEngName!,textAlign: TextAlign.end,
            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)
            
            ,),
            SizedBox(height: 3,),
            Text("Total Verses : $TotalVerses" , style: TextStyle(fontSize: 16,color: Colors.black54),)
          ]),
          Spacer(),
          Text(surahName!,textAlign: TextAlign.end,
            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
            ]),
    ),),
  );
}