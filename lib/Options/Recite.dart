import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quran_tutor/Quran_Tutor/Surah_screen.dart';
import 'package:quran_tutor/services/api_services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:quran_tutor/Quran_Tutor/SpeechText.dart';
import '../models/Data.dart';

class SpeechText extends StatefulWidget {
  const SpeechText({Key? key}) : super(key: key);
  static String VERSEC = '';
  @override
  State<SpeechText> createState() => _SpeechTextState();
}

class _SpeechTextState extends State<SpeechText> {
  String recognizedText = "";
  bool isEnabled = false;
  // List verseWords = [] ;
  // List reciteWords = [] ;
  // List mistakes = [];
  // bool mistake = true ;
  ApiService apiService = ApiService();
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
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: apiService.getVC(Const.surahIndex!),
                builder:
                    (BuildContext context, AsyncSnapshot<verseCList> snapshot) {
                  if (snapshot.hasData) {
                    var V = null;
                    if (surah_screen.VN == 3) {
                      V = snapshot.data!.verseList[(surah_screen.VN) - 3];
                    } else if (surah_screen.VN ==
                        snapshot.data!.verseList.length + 1) {
                      V = snapshot.data!.verseList[(surah_screen.VN) - 2];
                    } else {
                      V = snapshot.data!.verseList[(surah_screen.VN) - 3];
                    }
                    var vc = V.verseClean;
                    SpeechText.VERSEC = vc!;
                    var VC = SpeechText.VERSEC;
                    SpeechText.VERSEC = SpeechText.VERSEC
                        .replaceAll("بسم الله الرحمن الرحيم", "");
                    recognizedText = recognizedText.replaceAll("ا ل م", "الم");
                    recognizedText = recognizedText.replaceAll("ح م", "حم");
                    recognizedText = recognizedText.replaceAll("ط س م", "طسم");
                    VC = VC.replaceAll("بسم الله الرحمن الرحيم ", "");
                    VC = VC.replaceAll("كهيعص", "ك ه ي ع ص");
                    VC = VC.replaceAll("ابت", "ابتي");
                    VC = VC.replaceAll("أ", "ا");
                    VC = VC.replaceAll("إ", "ا");
                    VC = VC.replaceAll("آ", "ا");
                    VC = VC.replaceAll(" ۖ", "");
                    VC = VC.replaceAll(" ۛ", "");
                    VC = VC.replaceAll(" ۚ", "");
                    VC = VC.replaceAll("ة", "ه");
                    VC = VC.replaceAll("۞ ", "");

                    return Center(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text("${SpeechText.VERSEC}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          TextButton(
                              child: Text("Start Recite"),
                              onPressed: () {
                                _recognizedText();
                              }),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text("${recognizedText}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              Text(
                                "Your recite : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: recognizedText == ""
                                    ? Text("")
                                    : recognizedText == VC
                                        ? Text("Correct",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green))
                                        : Text(
                                            "Wrong",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                              ),
                            ],
                          ),
                          Container(
                            child: surah_screen.VN ==
                                    snapshot.data!.verseList.length + 1
                                ? SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      surah_screen.VN += 1;
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return SpeechText();
                                      }));
                                    },
                                    icon: Icon(Icons.arrow_right)),
                          )
                          // Container(
                          // child:
                          // mistake == false ? SizedBox() :
                          // ListView.builder(
                          // itemCount: verseWords.length ,
                          // itemBuilder: (context,index){
                          //   return Text(mistakes[index]);
                          // }
                          // ))
                        ],
                      ),
                    );
                  } else
                    return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
