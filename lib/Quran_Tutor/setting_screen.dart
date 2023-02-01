import 'package:flutter/material.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        
        actions: [
          // IconButton(onPressed:(){
          //   setState(() {
          //     // _IconBool = !_IconBool ;
          //   });
          // },
          // icon: Icon(_IconBool ? IconDark : IconLight ),
          // )
        ]),


      body: Center(child: Text("Setting")),));
  }
}