import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:quran_tutor/models/Data.dart';
import '../Audio/audio_screen.dart' ;

class ReciterScreen extends StatefulWidget {
  const ReciterScreen({Key? key , required this.reciter , required this.ontap }) : super(key:key);

  final Reciter reciter ; 
  final VoidCallback ontap ; 



  @override
  _ReciterScreenState createState() => _ReciterScreenState();
}

class _ReciterScreenState extends State<ReciterScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0,
                color: Colors.black12,
                offset: Offset(0, 1)
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.reciter.name!,textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
            ],
          ),
        ),

      ),
    );
  }
}

