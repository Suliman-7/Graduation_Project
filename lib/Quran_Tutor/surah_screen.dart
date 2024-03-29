import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:quran_tutor/Options/Bookmark.dart';
import 'package:quran_tutor/Options/FavoriteVerses.dart';
import 'package:quran_tutor/Quran_Tutor/surrah_controller.dart';
import 'package:quran_tutor/services/api_services.dart';
import '../Options/Recite.dart';
import '../models/Data.dart';

class surah_screen extends StatefulWidget {
  const surah_screen({super.key});

  static const String id = 'surahDetail_screen';
  static String BV = '';
  static List Fav = [];
  static int VN = 0;

  @override
  State<surah_screen> createState() => _surah_screenState();
}

class _surah_screenState extends State<surah_screen> {
  ApiService apiService = ApiService();

  var Arr = [];

  @override
  Widget build(BuildContext context) {
    SurrahController _surrahController = Get.put(SurrahController());
    return Scaffold(
        appBar: AppBar(
          title: GetBuilder<SurrahController>(
            builder: (controller) {
              return Text(
                  SurrahController.surahList?[Const.surahIndex ?? 0].name ??
                      '');
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.black54,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(children: [
            IconButton(
                icon: Const.surahIndex == 1
                    ? const SizedBox()
                    : Icon(Icons.arrow_left),
                onPressed: () {
                  if (Const.surahIndex! > 1) {
                    setState(() {
                      Const.surahIndex = (Const.surahIndex! - 1);
                      _surrahController.gotTonextSurrah();
                      Navigator.pushReplacementNamed(context, surah_screen.id);
                    });
                  }
                }),
            Spacer(),
            IconButton(
                icon: Const.surahIndex == 114
                    ? const SizedBox()
                    : Icon(Icons.arrow_right),
                onPressed: () {
                  if (Const.surahIndex! < 114) {
                    setState(() {
                      Const.surahIndex = (Const.surahIndex! + 1);
                      Navigator.pushReplacementNamed(context, surah_screen.id);
                    });
                  }
                }),
          ]),
        ),
        body: FutureBuilder(
            future: apiService.getverses(Const.surahIndex!),
            builder: (BuildContext context, AsyncSnapshot<surahList> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: (snapshot.data!.surahlist.length) + 1,
                  itemBuilder: (context, index) {
                    var length = (snapshot.data!.surahlist.length - 1);
                    var number = index;
                    var verse = ((length + 1) != index)
                        ? (snapshot.data!.surahlist[index])
                        : (snapshot.data!.surahlist[index - 1]);

                    if (number == 0) {
                      Arr.add("");
                      Arr.add(" ${verse.verse} { ${verse.verseNumber} } ");
                    } else {
                      Arr.add(" ${verse.verse} { ${verse.verseNumber} } ");
                    }

                    if (Const.surahIndex != 1) {
                      Arr[1] = Arr[1].toString().replaceAll(
                          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ', '');
                    }

                    if (index == 0 &&
                        Const.surahIndex != 1 &&
                        Const.surahIndex != 9) {
                      return Text(
                        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    } else if (index == 0 &&
                        (Const.surahIndex == 1 || Const.surahIndex == 9)) {
                      return Text("");
                    } else {
                      return TextButton(
                          onPressed: () {
                            var vn = verse.verseNumber! + 1;
                            var choosedverse = Arr[index];
                            openDialog(choosedverse, vn);
                          },
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "${Arr[index]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )));
                    }
                  },
                );
              } else
                return Center(
                  child: Text("verse not found"),
                );
            }));
  }

  Future<void> openDialog(choosedverse, vn) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              "Select Option",
              textAlign: TextAlign.center,
            ),
            children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.record_voice_over),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Recite"),
                  ],
                ),
                onPressed: () {
                  surah_screen.VN = vn;

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return SpeechText();
                  }));
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.star_outline),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Favorite"),
                  ],
                ),
                onPressed: () {
                  surah_screen.Fav.add(choosedverse);
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.bookmark_add),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Bookamrk"),
                  ],
                ),
                onPressed: () {
                  surah_screen.BV = choosedverse;
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Share"),
                  ],
                ),
                onPressed: () {
                  share(choosedverse);
                  // await Share.share(Sharedverse);
                },
              ),
            ],
          );
        })) {
      
    }
  }

  Future<void> share(var Verse) async {
    await FlutterShare.share(
        title: Verse, text: Verse, chooserTitle: 'Example Chooser Title');
  }
}
