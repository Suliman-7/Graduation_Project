

import 'package:get/get.dart';

import '../models/Data.dart';

class SurrahController extends GetxController {

static int? surahIndex ;
static String? SurahName ;
static List<SurahData>? surahList; 

  gotTonextSurrah(){

      Const.SurahName = Const.surahList?[ Const.surahIndex??0].name??'';
      update();
      print('we are in the go to next surrah ${ Const.surahList?[ Const.surahIndex??0].name??''}');



  }



}