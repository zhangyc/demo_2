import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reorderables/reorderables.dart';

import 'app.dart';
import 'bean/game_event.dart';
import 'generated/assets.dart';
import 'package:reorderables/reorderables.dart';
math.Random _random=math.Random();
class MyPage extends StatefulWidget {
  const MyPage({Key? key, required this.events}) : super(key: key);
  final List<GameEvent> events;
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin{
  double money=0.0;
  double energy=0.0;
  double pressure=0.0;
  late TabController _tabController;
  late Timer timer;
  Timer? downTimer;
  Set<GameEvent> baseLibrary={};
  List<GameEvent> selectedList=[];
  List<SubEvents> _showListR=[];
  List<SubEvents> _showList=[];
  GameEvent? currentEvent;
  int count=1;
  List<GameEvent> _list=[];
  int chuanqi=0;
  int currentEventTime=0;
  double progress=0.0;
  void updateEvent() {
    if(_list.isNotEmpty&&currentEvent!=null){
      SubEvents subEvents;
       if(currentEvent!.eventId=="1"){

         chuanqi=chuanqi+1;
         if(chuanqi>=10){
           chuanqi=0;
         }
         subEvents=currentEvent!.subEvents![chuanqi];
       }else {
         subEvents=currentEvent!.subEvents![_random.nextInt(currentEvent!.subEvents!.length)];
       }

      if(subEvents.rewards!=null&&subEvents.rewards!.isNotEmpty){

        subEvents.rewards!.forEach((element) {
          try{
            baseLibrary.add(_list.firstWhere((gameEvent) => gameEvent.eventId==element.eventId));
          }catch(e){

          }
          ///显示获取的
          showOkAlertDialog(context: context,message: '${subEvents.description}\n\n'
              '获取得事件卡:${element.eventName}');
          // Fluttertoast.showToast(
          //     msg: '${subEvents.description}\n获取得事件卡，${element.eventName}',
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0
          // );
        });

      }

      _showList.add(subEvents);
      _showListR=_showList.reversed.toList();
      energy=energy+subEvents.effects![0].effect!;
      pressure=pressure+subEvents.effects![1].effect!;
      money=money+subEvents.effects![2].effect!;
    }

  }
  Timer? testTimer;
  @override
  void initState() {
    // testTimer=Timer.periodic(Duration(seconds: 1), (value) {
    //   if(currentEvent!=null){
    //
    //     currentEventTime--;
    //     setState(() {
    //
    //     });
    //   }
    // });
    _list=widget.events;
    baseLibrary.add(widget.events.first);
    _tabController=TabController(length: 3, vsync: this);
    ///倒计时
    timer =Timer.periodic(period, (value){

      ///3s执行一次
      if(selectedList.isNotEmpty){
        currentEvent=selectedList.first;
        if(downTimer==null){
          currentEventTime=currentEvent!.duration!;
          count=currentEvent!.duration!;
          downTimer=Timer(Duration(seconds: currentEvent!.duration!)??Duration(seconds: 10), () {

            downTimer!.cancel();
            downTimer=null;
            ///结算并显示情节
            updateEvent();
            selectedList.removeAt(0);

            setState(() {

            });
            if(testTimer!=null){
              testTimer!.cancel();
            }
          });

        }else {
          if(downTimer!.isActive){
            currentEventTime--;
            progress=(count-currentEventTime)/count;
            print(progress);
            setState(() {

            });
          }else {
            downTimer=Timer(Duration(seconds: currentEvent!.duration!)??Duration(seconds: 10), () {
              downTimer!.cancel();
              downTimer=null;
              updateEvent();
              selectedList.removeAt(0);

              setState(() {

              });
            });

          }
        }
        setState(() {

        });

      }

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(

       ),
      floatingActionButton: FloatingActionButton(onPressed: (){
      },child: Icon(Icons.add_circle),),
      body: Column(
        children: <Widget>[
          Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(params[0]),
                      Text('${energy??''}')
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(params[1]),
                      Text('${pressure??''}')
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(params[2]),
                      Text('${money??''}')
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(params[3]),
                      Text('加速卡：无限使用')
                    ],
                  ),
                ),
              ]
          ),
          CircleAvatar(
            child: Image.asset(Assets.assetsA8abf62c3e7942523ac3af6e8a622b5b,width: 40,height: 40,),
          ),
          SizedBox(
            height: 100,
            child: ListView(
              reverse: true,
              children: _showListR.map((e) => ListTile(
                title: Text(e.emojiSummary??''),
                subtitle: Text(e.description??''),
              )).toList(),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child:LinearProgressIndicator(
              value:progress,
            ),
            alignment: Alignment.center,
          ),
          Container(
              color: Colors.blueGrey,
              height: 150,
              width: MediaQuery.of(context).size.width,

              child: ReorderableRow(
                scrollController: ScrollController(),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedList.map((e) => Container(height: 150,
                  width:150,
                  key: UniqueKey(),
                  color: Colors.white38,
                  margin: EdgeInsets.only(
                      right: 20
                  ),
                  child: Column(
                    children: [
                      SizedBox(child: Text(e.eventName??'',),height: 20,),
                      e==currentEvent?SizedBox(child: Text('剩余时间：${currentEventTime}',style: TextStyle(color: Colors.blue),),height: 20,):Container(),
                      SizedBox(
                        width: 50,
                        height: 100,
                        child: TextButton(onPressed: (){
                          if(downTimer!=null){
                            downTimer!.cancel();
                            downTimer=null;
                            ///结算并显示情节
                            updateEvent();
                            selectedList.removeAt(0);
                            setState(() {

                            });
                          }
                        }, child: Text('立即完成')),
                      ),
                    ],
                  ),
                )).toList(),

                onReorder: (v1,v2){
                  debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. ');

                },
                onNoReorder: (int index) {
                  //this callback is optional
                  debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                },
              )
          ),
          TabBar(tabs: List.generate(3, (index) => Tab(child: Text('$index'),)),controller: _tabController,),

          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(controller: _tabController,children: [
              ListView(
                children: baseLibrary.map((e) => GestureDetector(onTap: (){
                  GameEvent event=GameEvent();
                  event.uuid=uuid.v1();
                  event.duration=e.duration;
                  event.eventName=e.eventName;
                  event.eventId=e.eventId;
                  event.subEvents=e.subEvents;
                  event.rewards=e.rewards;
                  event.image=e.image;
                  selectedList.add(event);
                  // count=0;
                  // selectedList.forEach((element) {
                  //   count=count+element.duration!;
                  // });
                  setState(() {

                  });
                },child: Container(child: Text(e.eventName??''),
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.blue,))).toList(),
              ),
              ListView(
                children: baseLibrary.map((e) => GestureDetector(onTap: (){
                  selectedList.add(e..uuid=uuid.v4());
                  setState(() {

                  });
                },child: Container(child: Text(e.eventName??''),
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.blue,))).toList(),
              ),
              ListView(
                children: baseLibrary.map((e) => GestureDetector(onTap: (){
                  selectedList.add(e..uuid=uuid.v4());
                  setState(() {

                  });
                },child: Container(child: Text(e.eventName??''),
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.blue,))).toList(),
              ),
            ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  double _computeValue() {
    if(selectedList.isEmpty){
      return 0;
    }
    int tmp=0;
    selectedList.forEach((element) {
      tmp=tmp+element.duration!;
    });
    return (tmp/count);
  }
}
