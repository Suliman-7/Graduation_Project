import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:quran_tutor/models/Data.dart';


Widget surahCustomListTile({
  required SurahData Sur ,
  required BuildContext context ,
  required VoidCallback ontap
  
  })


{
  return GestureDetector(
   
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(16.0),
      
      child: 
      Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,),
                child: Text((Sur.number).toString(),
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Sur.englishName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                Text("${Sur.typeOfRevelation!} - ${Sur.numberOfVerses} Verses" , style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
            Spacer(),
            Text(Sur.name!,style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 24),),
            Spacer(),
            IconButton(
              onPressed: () {
              
              Const.SurahName = Sur.name! ;
              SurahL.FavSur.add(Sur.name!) ; 
              SurahL.FavSurNum.add(Sur.number!) ; 
              }, 
              icon: Icon(Icons.star)

            
            )
          ],
        ),
        Divider(thickness: 3)
      ]),
       ),
  );
}

class SurahL extends StatefulWidget {

  const SurahL({super.key});
  static List FavSur = [] ; 
  static List FavSurNum = [] ;
  @override
  State<SurahL> createState() => _SurahLState();
}

class _SurahLState extends State<SurahL> {
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}