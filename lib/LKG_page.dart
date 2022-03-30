import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:school/video_screen.dart';

class LKGVideoInfo extends StatefulWidget {
  const LKGVideoInfo({Key? key}) : super(key: key);

  @override
  _LKGVideoInfoState createState() => _LKGVideoInfoState();
}

class _LKGVideoInfoState extends State<LKGVideoInfo> {

  List videoInfo = [];
  bool _videoPlayed = false;

  _initData() async {
    await DefaultAssetBundle.of(context).loadString("json/video_info.json").then((value){
      setState(() {
        videoInfo= json.decode(value);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xff4D7482),Color(0xFF87F9BB)],
            begin: const FractionalOffset(0.0, 0.4),
          end: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top:70, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Text("LKG", style: TextStyle(
                fontSize: 35,
                color: Color(0xFFfefeff)
              ),),
            ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70))
            ),
            child: Column(
              children: [
              SizedBox(height: 10,),
            Row(
              children: [
              SizedBox(width: 30,),
            Text(
              "Learning Videos",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:Color(0xFF2f2f51)
              ),
            ),
            ]),
                Expanded(
                    child:_listView()
                )
              ]
            ),
          ),
        ),
          ],
        ),
      )
    );
  }
  _listView(){
    return ListView.builder(
        itemCount: videoInfo.length,
        itemBuilder: (_, int index){
          return GestureDetector(
              onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>VideoScreen(
                    title: videoInfo[index]["title"],
                    videoUrl: videoInfo[index]["videoUrl"]
                  ))
              ),
              child: _widgetCard(index)
          );
        });
  }
  _widgetCard(int index){
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 125,
      width: 200,
      // color: Colors.blueAccent,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(videoInfo[index]["thumbnail"]),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Text(
                    videoInfo[index]["title"],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
