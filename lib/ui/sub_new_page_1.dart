import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewPageFirst extends StatefulWidget {
  @override
  _NewPageFirstState createState() => _NewPageFirstState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _NewPageFirstState extends State<NewPageFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text(
          "New PAGE 1",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Container(),
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
