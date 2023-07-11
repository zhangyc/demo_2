import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController _textEditingController1=TextEditingController();
  TextEditingController _textEditingController2=TextEditingController();
  TextEditingController _textEditingController3=TextEditingController();
  TextEditingController _textEditingController4=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textEditingController1,
        ),
        TextField(
          controller: _textEditingController2,
        ),
        TextField(
          controller: _textEditingController3,
        ),
        TextField(
          controller: _textEditingController4,
        ),
        ElevatedButton(onPressed: (){

        }, child: Icon(Icons.add))
      ],
    );
  }
}
