import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quran_tutor/Const/Const.dart';
import 'package:quran_tutor/Quran_Tutor/home_screen.dart';

class OBS extends StatefulWidget {
  const OBS({super.key});

  @override
  State<OBS> createState() => _OBSState();
}

class _OBSState extends State<OBS> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IntroductionScreen(
          pages: [
                PageViewModel(
                  title: "Read Quran",
                  bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                  Text("read holy Quran"),
                    ],
                  ),
                  image: Center(child: Image.asset('assets/quran.png',fit: BoxFit.fitWidth,)),
                ),
                PageViewModel(
                  title: "Open Surah",
                  bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                  Padding(padding: EdgeInsets.all(8.0),
                  child : Text("Open surah to read"),)
                    ],
                  ),
                  image: Center(child: Image.asset('assets/prayer.png',fit: BoxFit.cover,)),
                ),
                PageViewModel(
                  title: "Search",
                  bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                  Padding(padding: EdgeInsets.all(8.0),
                  child : Text("Search for any verse you want" , 
                  textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),)
                    ],
                  ),
                  image: Center(child: Image.asset('assets/search.png',fit: BoxFit.cover,)),
                ),
          ],




          onDone: () {
    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (context)=>HomeScreen()));
  },
  
  showNextButton: true,
  next: const Icon(Icons.arrow_forward,color: Colors.black,),
  done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
  dotsDecorator: DotsDecorator(
    size: const Size.square(10.0),
    activeSize: const Size(20.0, 10.0),
    activeColor: Const.kPrimary,
    color: Colors.grey ,
    spacing: const EdgeInsets.symmetric(horizontal: 3.0),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0)
    ),
  ),
)


    ));
  }
}