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
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.transparent, blurRadius: 3.0)]
      ),
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
                  shape: BoxShape.circle,
                  color: Colors.black87,
                                         ),
                child: Text((Sur.number).toString(),
                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Sur.englishName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                Text("${Sur.typeOfRevelation!} - ${Sur.numberOfVerses} Verses" , style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54),)
              ],
            ),
            // Spacer(),
            Text(Sur.name!,style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),

            IconButton(
              
              onPressed: () {
              SurahL.FavSur.add(Sur.name!) ; 
              SurahL.FavSurNum.add(Sur.number!) ; 
              }, 
              icon: Icon(Icons.star))

            
            
          ],
        ),
        Divider(thickness: 3,color: Colors.black,)
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