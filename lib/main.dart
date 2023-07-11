import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:demo_2/game_loading.dart';
import 'package:demo_2/generated/assets.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reorderables/reorderables.dart';
math.Random _random=math.Random();
void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameLoading(),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
//   late TabController _tabController;
//   GameEvent event=GameEvent(
//     energyChange: 0,
//     pressureChange: 0,
//     moneyChange: 0
//   );
//   List<Story> _list=[];
//   List<Story> _showList=[];
//   List<Story> _showListR=[];
//   int count=1;
//   late Timer timer;
//   ///当前正在执行的。
//   @override
//   void initState() {
//     DefaultAssetBundle.of(context).loadString(Assets.dataStoers).then((value){
//        List list =jsonDecode(value);
//        _list=list.map((e) => Story.fromJson(e)).toList();
//        log(list.length.toString());
//     });
//     _tabController=TabController(length: 3, vsync: this);
//     //定时人物，3s执行一次。
//
//
//     ///倒计时
//     timer =Timer.periodic(period, (value){
//       log('1');
//         ///3s执行一次
//       if(selectedList.isNotEmpty){
//         currentEvent=selectedList.first;
//         if(downTimer==null){
//           downTimer=Timer(Duration(seconds: currentEvent!.duration!)??Duration(seconds: 10), () {
//               downTimer!.cancel();
//               downTimer=null;
//               ///结算并显示情节
//               updateEvent();
//               selectedList.removeAt(0);
//               setState(() {
//
//               });
//           });
//         }else {
//           if(downTimer!.isActive){
//             event.duration=downTimer!.tick;
//           }else {
//             downTimer=Timer(Duration(seconds: currentEvent!.duration!)??Duration(seconds: 10), () {
//               downTimer!.cancel();
//               downTimer=null;
//               updateEvent();
//               selectedList.removeAt(0);
//               setState(() {
//
//               });
//             });
//           }
//         }
//         setState(() {
//
//         });
//
//       }
//
//     });
//     super.initState();
//   }
//
//   void updateEvent() {
//     if(_list.isNotEmpty&&currentEvent!=null){
//       List.generate(currentEvent!.plotNumber!, (index){
//         _showList.add(_list[_random.nextInt(_list.length)]);
//       });
//       _showListR=_showList.reversed.toList();
//     }
//     event.energyChange=event.energyChange!+currentEvent!.energyChange!;
//     event.pressureChange=event.pressureChange!+currentEvent!.pressureChange!;
//     event.moneyChange=event.moneyChange!+currentEvent!.moneyChange!;
//   }
//   Timer? downTimer;
//   GameEvent? currentEvent;
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(onPressed: (){
//
//
//       },child: Icon(Icons.add_circle),),
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//
//       body: Column(
//         children: <Widget>[
//           Row(
//             children: [
//               Container(
//                 child: Row(
//                   children: [
//                     Icon(params[0]),
//                     Text('${event.moneyChange??''}')
//                   ],
//                 ),
//               ),
//               Container(
//                 child: Row(
//                   children: [
//                     Icon(params[1]),
//                     Text('${event.pressureChange??''}')
//                   ],
//                 ),
//               ),
//               Container(
//                 child: Row(
//                   children: [
//                     Icon(params[2]),
//                     Text('${event.energyChange??''}')
//                   ],
//                 ),
//               ),
//               Container(
//                 child: Row(
//                   children: [
//                     Icon(params[3]),
//                     Text('加速卡：100')
//                   ],
//                 ),
//               ),
//             ]
//           ),
//           CircleAvatar(
//             child: Image.asset(Assets.assetsA8abf62c3e7942523ac3af6e8a622b5b,width: 40,height: 40,),
//           ),
//           SizedBox(
//             height: 100,
//             child: ListView(
//               reverse: true,
//               children: _showListR.map((e) => ListTile(
//                 title: Text(e.emojiSummary??''),
//                 subtitle: Text(e.plotDescription??''),
//               )).toList(),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: 50,
//             child:LinearProgressIndicator(
//               value: selectedList.length/count,
//             ),
//             alignment: Alignment.center,
//           ),
//           Container(
//             color: Colors.blueGrey,
//               height: 150,
//             width: MediaQuery.of(context).size.width,
//             child: ReorderableRow(
//               scrollController: ScrollController(),
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: selectedList.map((e) => Container(height: 120,
//                   width:50,
//                   child: Text(e.eventName??'',),
//                   key: UniqueKey(),
//                 color: Colors.white38,
//                 margin: EdgeInsets.only(
//                   right: 20
//                 ),
//               )).toList(),
//
//               onReorder: (v1,v2){
//                 debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. ');
//
//               },
//               onNoReorder: (int index) {
//                 //this callback is optional
//                 debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
//               },
//             )
//           ),
//           TabBar(tabs: List.generate(3, (index) => Tab(child: Text('$index'),)),controller: _tabController,),
//
//           SizedBox(
//             height: 200,
//             width: MediaQuery.of(context).size.width,
//             child: TabBarView(controller: _tabController,children: [
//               ListView(
//                 children: libraryList.map((e) => GestureDetector(onTap: (){
//                   selectedList.add(e);
//                   count=selectedList.length;
//
//                   setState(() {
//
//                   });
//                 },child: Container(child: Text(e.eventName??''),
//                   width: MediaQuery.of(context).size.width,
//                   height: 30,
//                   margin: EdgeInsets.only(bottom: 10),
//                   color: Colors.blue,))).toList(),
//               ),
//               ListView(
//                 children: libraryList.map((e) => GestureDetector(onTap: (){
//                   selectedList.add(e);
//                   setState(() {
//
//                   });
//                 },child: Container(child: Text(e.eventName??''),
//                   width: MediaQuery.of(context).size.width,
//                   height: 30,
//                   margin: EdgeInsets.only(bottom: 10),
//                   color: Colors.blue,))).toList(),
//               ),
//               ListView(
//                 children: libraryList.map((e) => GestureDetector(onTap: (){
//                   selectedList.add(e);
//                   setState(() {
//
//                   });
//                 },child: Container(child: Text(e.eventName??''),
//                   width: MediaQuery.of(context).size.width,
//                   height: 30,
//                   margin: EdgeInsets.only(bottom: 10),
//                   color: Colors.blue,))).toList(),
//               ),
//              ],
//             ),
//           ),
//         ],
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//   List<GameEvent> selectedList=[];
//   int conunt = 0;
//
// //注销定时器
//   @override
//   void dispose(){
//   timer.cancel();
//   super.dispose();
//   }
// }
// List<GameEvent> libraryList=[
//   GameEvent(duration: 3, energyChange: -20, pressureChange: -50, moneyChange:  -50,eventName: '事件1',plotNumber: 3),
//   GameEvent(duration: 3, energyChange: -20, pressureChange: -50, moneyChange:  -50,eventName: '事件2',plotNumber: 3),
//   GameEvent(duration: 3,  energyChange: -20, pressureChange: -50, moneyChange:  -50,eventName: '事件3',plotNumber: 3),
//   GameEvent(duration: 3,  energyChange: -20, pressureChange: -50, moneyChange:  -50,eventName: '事件4',plotNumber: 3),
//   GameEvent(duration: 3, energyChange: -20, pressureChange: -50, moneyChange:  -50,eventName: '事件5',plotNumber: 3),
// ];


// class Event{
//    Duration? duration;  ///单位统一使用秒
//    double? energy=0;
//    double? pressure=0;
//    double? wealth=0;
//    String? name;
//
//    Event.d();
//    Event({required this.duration,required this.energy,required this.pressure,required this.wealth,this.name});
// }
// class Story {
//   String? plotName; ///情节名称
//   String? plotDescription; ///情节描述
//   String? emojiSummary; ///使用emoji作为简介
//   int? duration; ///情节持续时间
//   String? plotType; ///情节类型
//   int? energyChange; ///精力
//   int? pressureChange; ///压力
//   int? moneyChange; ///财富
//
//   Story(
//       {this.plotName,
//         this.plotDescription,
//         this.emojiSummary,
//         this.duration,
//         this.plotType,
//         this.energyChange,
//         this.pressureChange,
//         this.moneyChange});
//
//   Story.fromJson(Map<String, dynamic> json) {
//     plotName = json['plot_name'];
//     plotDescription = json['plot description'];
//     emojiSummary = json['emoji_summary'];
//     duration = json['duration'];
//     plotType = json['plot_type'];
//     energyChange = json['energy_change'];
//     pressureChange = json['pressure_change'];
//     moneyChange = json['money_change'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['plot_name'] = this.plotName;
//     data['plot description'] = this.plotDescription;
//     data['emoji_summary'] = this.emojiSummary;
//     data['duration'] = this.duration;
//     data['plot_type'] = this.plotType;
//     data['energy_change'] = this.energyChange;
//     data['pressure_change'] = this.pressureChange;
//     data['money_change'] = this.moneyChange;
//     return data;
//   }
// }
// class GameEvent {
//   String? emojiDemonstration='🏋️♂️🎵💦';  ///emoji
//   int? duration=1; ///事件持续时间
//   int? energyChange=0; ///精力变化
//   int? pressureChange=0; ///压力变化
//   int? moneyChange=0; ///财富变化
//   int? plotNumber=2; ///本事件包含几个情节
//   String? eventName=''; ///事件名称
//   GameEvent(
//       {this.emojiDemonstration,
//         this.duration,
//         this.energyChange,
//         this.pressureChange,
//         this.moneyChange,
//         this.plotNumber,
//         this.eventName
//       });
//
//   GameEvent.fromJson(Map<String, dynamic> json) {
//     emojiDemonstration = json['emoji_demonstration'];
//     eventName = json['eventName'];
//     duration = json['duration'];
//     energyChange = json['energy_change'];
//     pressureChange = json['pressure_change'];
//     moneyChange = json['money_change'];
//     plotNumber = json['plot_number'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['emoji_demonstration'] = this.emojiDemonstration;
//     data['duration'] = this.duration;
//     data['energy_change'] = this.energyChange;
//     data['pressure_change'] = this.pressureChange;
//     data['money_change'] = this.moneyChange;
//     data['plot_number'] = this.plotNumber;
//     data['eventName'] = this.eventName;
//     return data;
//   }
// }