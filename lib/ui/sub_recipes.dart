
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class RecipesPage extends StatefulWidget{
  @override
  _RecipesPageState createState() => _RecipesPageState();

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _RecipesPageState extends State<RecipesPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text("RECIPE PAGE"),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Center(
        child:
          Text("Your text"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        tooltip: 'Increment',
        child: Icon(
          FontAwesomeIcons.userPlus,
          size: 20,
        ),
      ),
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
