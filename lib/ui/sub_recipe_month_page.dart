
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class RecipeMonthPage extends StatefulWidget{
  String str_show = "";
  RecipeMonthPage(@required this.str_show);
  @override
  _RecipeMonthPageState createState() => _RecipeMonthPageState();

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _RecipeMonthPageState extends State<RecipeMonthPage>{

  @override
  Widget build(BuildContext context) {
    print(widget.str_show);
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text("RECIPE MONTH",style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Center(
        child:
        Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Container(
            child: Text(
              widget.str_show,
              style: TextStyle(color: Colors.blueAccent, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
