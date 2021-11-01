import 'dart:ui';

import 'package:data_buffer/services/theme_service.dart';
import 'package:data_buffer/ui/sub_dentist_page.dart';
import 'package:data_buffer/ui/sub_milk_teeth_page.dart_page.dart';
import 'package:data_buffer/ui/widgets/customappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:data_buffer/ui/sub_advice_description_page.dart';
import 'package:data_buffer/ui/sub_hospital.dart';

class AdvicesPage extends StatefulWidget {
  String user_role = "", user_name = "";
  AdvicesPage(@required this.user_role, @required this.user_name);

  @override
  _AdvicesPageState createState() => _AdvicesPageState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _AdvicesPageState extends State<AdvicesPage> {
  ThemeService themeService = ThemeService();
  final TextStyle whiteText = TextStyle(color: Colors.white);
  double _height;
  double _width;

  Widget cards(image, bgcolor, title, subtitle, price, page_num) {
    return GestureDetector(
      onTap: () {
        switch (page_num) {
          case 1:
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => AdviceDescriptionPage()));
            break;
          case 2:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    HospitalPage(widget.user_role, widget.user_name)));
            break;
          case 3:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => DentistPage()));
            break;
          case 4:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => MilkTeethPage()));
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6.0,
            ),
          ],
          color: bgcolor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                image,
                width: _width / 3,
              ),
              SizedBox(
                width: _width / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width / 21,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: _width / 40),
                      Text(subtitle,
                          style: TextStyle(
                              fontSize: _width / 35,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
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
                  Color(themeService.myColor1),
                  Color(themeService.myColor2),
                ])),
            child: ListView(
              children: <Widget>[
                Container(
                  height: _height / 3,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Opacity(
                            opacity: 1,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                print("pop");
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(children: <Widget>[
                            Row(children: <Widget>[
                              Container(
                                height: _height / 3 - 50,
                                width: _width,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                      Color(themeService.myColor1),
                                      Color(themeService.myColor2),
                                    ])),
                                child: Container(
                                  child: Image.asset(
                                    "assets/images/advice.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ]),
                            Row(children: <Widget>[
                              Container(
                                  height: _height / 3 - 50,
                                  margin: EdgeInsets.zero,
                                  width: _width,
                                  child: Container(
                                    child: Text(
                                        "ORAL HYGIENE FROM\n THE FIRST DAYS",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: _width / 12,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white)),
                                  )),
                            ]),
                            Row(children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 30, right: 30, top: _height / 7),
                                  height: _height / 3 - 50,
                                  margin: EdgeInsets.zero,
                                  width: _width,
                                  child: Container(
                                    child: Text(
                                        "If you get into difficulties, don't hesitate to ask for advice.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            letterSpacing: 1,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white)),
                                  )),
                            ]),
                          ])
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: _height * 0.7,
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
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          cards(
                              "assets/images/advice_oral_hygiene.png",
                              Color.fromRGBO(255, 240, 240, 1),
                              'ORAL HYGIENE',
                              // 'Lorem ipsum dolor sit amt,\nconsectetur adipiscing elit.\nFusce porta enim id nisi int',
                              'Keeping one\'s mouth clean\nand free of disease and\nother problems',
                              '30',
                              1),
                          cards(
                              "assets/images/advice_doctor.png",
                              Color.fromRGBO(255, 255, 240, 1),
                              'PEDIATRICIAN',
                              'Don\'t be afraid of seeing the\ndoctor. Doctors give you big\nchance.',
                              '37',
                              2),
                          cards(
                              "assets/images/advice_dentist.png",
                              Color.fromRGBO(255, 240, 255, 1),
                              'FIRST VISIT TO\nTHE DENTIST',
                              'How often do you have to see\nthe dentist? You should go to\na dentist immediately. ',
                              '22',
                              3),
                          cards(
                              "assets/images/advice_dentist.png",
                              Color.fromRGBO(255, 255, 240, 1),
                              'ORAL HYGIENE\nOF MILK TEETH',
                              'How often do you have to see\nthe dentist? You should go to\na dentist immediately. ',
                              '22',
                              4),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ),
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
