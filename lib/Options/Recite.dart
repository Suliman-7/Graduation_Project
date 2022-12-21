import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quran_tutor/Quran_Tutor/surah_screen.dart';
import 'package:quran_tutor/services/api_services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:quran_tutor/Quran_Tutor/SpeechText.dart';

import '../Const/Const.dart';
import '../models/Data.dart';

class SpeechText extends StatefulWidget {
  const SpeechText({Key? key}) : super(key: key);
  static String VERSEC = '' ;
  @override
  State<SpeechText> createState() => _SpeechTextState();
}

class _SpeechTextState extends State<SpeechText> {
  String recognizedText = "Recognize text is";
  bool isEnabled = false;
  ApiService apiService = ApiService() ;
  @override
  void initState() {
    super.initState();
    _checkSpeechAvailability();
  }

  _checkSpeechAvailability() async {
    isEnabled = await SpeechTextRecognizer.initialize();
    setState(() {});
  }

  _recognizedText() async {
    await SpeechTextRecognizer.startListning(speechRecogListner);
  }

  void speechRecogListner(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    recognizedText = result.recognizedWords;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Speech to Text"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            child: !SpeechTextRecognizer.isListning()
                ? const Icon(Icons.mic)
                : const Icon(Icons.stop),
            onPressed: () {
              SpeechTextRecognizer.isListning()
                  ? SpeechTextRecognizer.stopListning
                  : _recognizedText();
            }),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                FutureBuilder (
         
        future: apiService.getV(Const.surahIndex!), 
        builder: (BuildContext context, AsyncSnapshot<verseCList> snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          if (snapshot.hasData){ 
            var V = null ;   
            if (surah_screen.QN == 0) {
            V = snapshot.data!.verseList[(surah_screen.QN)+1];
            }
            else {
            V = snapshot.data!.verseList[(surah_screen.QN)-1];
            }
            var vc = V.verseClean ;
            SpeechText.VERSEC = vc! ; 
            var VC = SpeechText.VERSEC ;
            VC = VC.replaceAll("أ", "ا");
            VC = VC.replaceAll("إ", "ا");
            VC = VC.replaceAll("آ", "ا");
            VC = VC.replaceAll(" ۖ", "");
            VC = VC.replaceAll(" ۛ", "");
            VC = VC.replaceAll(" ۚ", "");
            VC = VC.replaceAll("ة","ه");
            print(VC);
            if (recognizedText==VC){
              print("Correct");
            }
            else {
              print("Wrong");
            }
            return Text("${SpeechText.VERSEC}");
          }

          else return Center(child: Text("verse not found"),);
          }

    ),
            const SizedBox(height: 15),
            
            Text(
              recognizedText,

              style: const TextStyle(fontSize: 18),
            ),
            
          ],
        ),
      ),
    );
  }
}