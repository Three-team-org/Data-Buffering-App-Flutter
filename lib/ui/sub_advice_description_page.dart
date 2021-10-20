import 'package:data_buffer/ui/widgets/customappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdviceDescriptionPage extends StatefulWidget {
  @override
  _AdviceDescriptionPageState createState() => _AdviceDescriptionPageState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _AdviceDescriptionPageState extends State<AdviceDescriptionPage> {
  double _width, _height;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color(0xFFE14C37),
                  Color(0xFFF5A327),
                ])),
            child: ListView(
              children: <Widget>[
                Container(
                  height: _height / 5,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Opacity(opacity: 1, child: CustomAppBar()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Advice details page".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _width / 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: _height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: _height / 30,
                    right: _width / 20,
                    bottom: _height / 30,
                    left: _width / 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tellus justo, "
                        "venenatis pretium urna posuere, malesuada tempus lectus. Curabitur molestie efficitur eros,"
                        " eu sodales elit malesuada eu. Nunc auctor consequat tincidunt. Sed id mi a dui scelerisque ",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
