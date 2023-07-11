import 'dart:convert';

import 'package:demo_2/bean/game_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'generated/assets.dart';
import 'my_page.dart';

class GameLoading extends StatefulWidget {
  const GameLoading({Key? key}) : super(key: key);

  @override
  State<GameLoading> createState() => _GameLoadingState();
}

class _GameLoadingState extends State<GameLoading> {
  List<GameEvent> _list=[];
  @override
  void initState() {
    DefaultAssetBundle.of(context).loadString(Assets.dataEvents).then((value){
      List list =jsonDecode(value);
      _list=list.map((e) => GameEvent.fromJson(e)).toList();
         Navigator.push<void>(
           context,
           MaterialPageRoute<void>(
             builder: (BuildContext context) =>MyPage(events: _list,),
           ),
         );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(child: CupertinoActivityIndicator(),width: 50,height: 50,),
          Text("游戏正在加载中，请稍后。。。")
        ],
      ),
    );
  }
}
