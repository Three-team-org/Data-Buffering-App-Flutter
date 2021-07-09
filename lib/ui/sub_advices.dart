
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class AdvicesPage extends StatefulWidget{
  @override
  _AdvicesPageState createState() => _AdvicesPageState();

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _AdvicesPageState extends State<AdvicesPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text("ADVICES PAGE"),
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
