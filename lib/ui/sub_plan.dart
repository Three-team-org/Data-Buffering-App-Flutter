
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:data_buffer/ui/sub_recipe_month_page.dart';
import 'package:data_buffer/ui/sub_recipes.dart';
import 'package:data_buffer/ui/sub_calendar.dart';
class PlanPage extends StatefulWidget{
  String user_role = "", user_name = "";
  PlanPage(@required this.user_role, @required this.user_name);
  @override
  _PlanPageState createState() => _PlanPageState();

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _PlanPageState extends State<PlanPage>{

  Widget cards(image, title, price, page_num) {
    return GestureDetector(
      onTap: (){
        switch(page_num){
          case 1:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => RecipesPage()));
            break;
          case 2:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => CalendarPage(widget.user_role, widget.user_name)));
            break;
        }
      },
      child:Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6.0,
            ),
          ],
          color: Colors.grey[100],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                image,
                height: 80,
              ),
              SizedBox(
                height: 10,
              ),
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.orangeAccent.shade200,)),
            ],
          ),
        ),
      ) ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
        appBar: AppBar(
          title: Text("PLANS",style: TextStyle(color: Colors.white, fontSize: 25),),
          backgroundColor: Colors.red,
          elevation: 0,
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Colors.orangeAccent.shade700,
                ),
                width: double.infinity,
              ),
              Container(
                margin: EdgeInsets.only(left: 90, bottom: 20),
                width: 200,
                height: 180,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent.shade200,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(160),
                        bottomLeft: Radius.circular(290),
                        bottomRight: Radius.circular(160),
                        topRight: Radius.circular(10))),
              ),
              CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Spacer(),
                              Text("RECIPE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white)),
                              Spacer(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(20.0),
                    sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: <Widget>[
                        cards("assets/images/icon_recipe.png", 'RECIPES', '37', 1),
                        cards("assets/images/icon_calendar.jpg", 'CALENDAR', '22', 2),

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
