import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:quran_tutor/models/Data.dart';

Widget surahCustomListTile({
  required SurahList surah ,
  required BuildContext context ,
  required VoidCallback ontap})
{
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3.0)]
      ),
      child: 
      Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 40,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(137, 239, 231, 193),
                                         ),
                child: Text((surah.number).toString(),
                style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(surah.englishName!,style: TextStyle(fontWeight: FontWeight.bold),),
                Text("${surah.typeOfRevelation!} - ${surah.numberOfVerses} verses")
              ],
            ),
            Spacer(),
            Text(surah.name!,style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20
            ),),
            
          ],
        ),
        Divider(thickness: 1,color: Colors.black,)
      ]),
       ),
  );
}