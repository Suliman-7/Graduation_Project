import 'dart:async';
import 'package:quran_tutor/Quran_Tutor/home_page.dart';
import 'package:quran_tutor/Quran_Tutor/home_screen.dart';

import 'o_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' ;


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool alreadyUsed = false ; 

  void getdata()async{
    final prefs = await SharedPreferences.getInstance();
    alreadyUsed = prefs.getBool("alreadyUsed") ?? false ;
  }

  
  @override
  void initState() {
    
    super.initState();
    getdata();
    Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (context){ return alreadyUsed ? HomeScreen() : OBS();
    })));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Center(child: Text("Quran Tutor",style: TextStyle(fontSize: 30,color: Colors.black,),),),
          Positioned(right: 0 , bottom: 0 , left: 0 , child: Image.asset('assets/islamic.png'))
        ],),
      ),
    );
  }
}