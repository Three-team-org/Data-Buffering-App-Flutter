
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:data_buffer/ui/sub_new_page_1.dart';
import 'package:data_buffer/ui/sub_new_page_2.dart';
class NewPage extends StatefulWidget{
  @override
  _NewPageState createState() => _NewPageState();

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _NewPageState extends State<NewPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text("New PAGE",style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Center(
        child:
        Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child:
          Column(
            children: <Widget>[
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tellus justo, "
                      "venenatis pretium urna posuere, malesuada tempus lectus. Curabitur molestie efficitur eros,"
                      " eu sodales elit malesuada eu. Nunc auctor consequat tincidunt. Sed id mi a dui scelerisque "
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => NewPageFirst()));
                  },
                  child: Text("NEW BUTTON 1", style: TextStyle(
                      color: Colors.white
                  ),),
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => NewPageSecond()));
                  },
                  child: Text("NEW BUTTON 2", style: TextStyle(
                      color: Colors.white
                  ),),
                ),
              ),
            ],
          )
        ),

      ),
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
