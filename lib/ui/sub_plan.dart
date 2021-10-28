import 'package:data_buffer/services/theme_service.dart';
import 'package:data_buffer/ui/widgets/customappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:data_buffer/ui/sub_recipe_month_page.dart';
import 'package:data_buffer/ui/sub_recipes.dart';
import 'package:data_buffer/ui/sub_calendar.dart';

class PlanPage extends StatefulWidget {
  String user_role = "", user_name = "";
  PlanPage(@required this.user_role, @required this.user_name);
  @override
  _PlanPageState createState() => _PlanPageState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _PlanPageState extends State<PlanPage> {
  ThemeService themeService = ThemeService();
  double _height;
  double _width;
  Widget cards(image, title, subtitle, price, page_num) {
    return GestureDetector(
      onTap: () {
        switch (page_num) {
          case 1:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => RecipesPage()));
            break;
          case 2:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    CalendarPage(widget.user_role, widget.user_name)));
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade50,
            ),
          ],
          border: Border.all(color: Colors.black26, width: 0.5),
          color: Colors.grey[100],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                image,
                height: _width / 3,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _width / 30,
                  color: Color.fromRGBO(45, 35, 25, 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: _width / 30,
                      color: Colors.black38,
                      fontStyle: FontStyle.italic)),
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
        // backgroundColor: Colors.deepOrange,
        //   appBar: AppBar(
        //     title: Text("PLANS",style: TextStyle(color: Colors.white, fontSize: 25),),
        //     backgroundColor: Colors.red,
        //     elevation: 0,
        //   ),
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            height: _height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color(themeService.myColor1),
                  Color(themeService.myColor2),
                ])),
            width: double.infinity,
          ),
          Container(
            width: _width,
            margin: EdgeInsets.only(top: _height / 3),
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
          Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: <Widget>[],
              )),
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Spacer(),
                          Text("NUTRITION PLAN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: _width / 10,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                          Spacer(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Failing to plan is planning to fail. ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: _width / 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[SizedBox(height: 60)],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: _width * 1.15 / _height,
                  children: <Widget>[
                    cards(
                        "assets/images/icon_recipe.png",
                        'RECIPES',
                        "Our recipe is much of course, it is all important; but it is not all.",
                        '37',
                        1),
                    cards(
                        "assets/images/calendar_button.png",
                        "GRADUAL \nINTRODUCTION\nOF FOODSTUFFS",
                        "All of this will be understood by examining our calendar.",
                        '22',
                        2),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
