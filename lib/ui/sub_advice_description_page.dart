
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class AdviceDescriptionPage extends StatefulWidget{
  @override
  _AdviceDescriptionPageState createState() => _AdviceDescriptionPageState();

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _AdviceDescriptionPageState extends State<AdviceDescriptionPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text("ADVICE DETAILS PAGE",style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Center(
        child:
        Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tellus justo, "
                  "venenatis pretium urna posuere, malesuada tempus lectus. Curabitur molestie efficitur eros,"
                  " eu sodales elit malesuada eu. Nunc auctor consequat tincidunt. Sed id mi a dui scelerisque "
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
