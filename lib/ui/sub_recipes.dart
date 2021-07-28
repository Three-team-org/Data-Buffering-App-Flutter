
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:data_buffer/ui/sub_recipe_month_page.dart';
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

  Widget cards(image, title, price, page_num) {
    return GestureDetector(
      onTap: (){
        switch(page_num){
          case 1:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => RecipeMonthPage()));
            break;
          case 2:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => RecipeMonthPage()));
            break;
          case 3:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => RecipeMonthPage()));
            break;
          case 4:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => RecipeMonthPage()));
            break;
          case 5:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => RecipeMonthPage()));
            break;
          case 6:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => RecipeMonthPage()));
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
        title: Text("RECIPE PAGE",style: TextStyle(color: Colors.white, fontSize: 25),),
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
                              Text("MY DASHBOARD",
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
                        cards("assets/images/icon_calendar.jpg", 'January', '30', 1),
                        cards("assets/images/icon_calendar.jpg", 'February', '37', 2),
                        cards("assets/images/icon_calendar.jpg", 'March', '22', 3),
                        cards("assets/images/icon_calendar.jpg", 'April', '90', 4),
                        cards("assets/images/icon_calendar.jpg", 'May', '22', 5),
                        cards("assets/images/icon_calendar.jpg", 'June', '90', 6),
                        cards("assets/images/icon_calendar.jpg", 'July', '30', 7),
                        cards("assets/images/icon_calendar.jpg", 'August', '37', 8),
                        cards("assets/images/icon_calendar.jpg", 'September', '22', 9),
                        cards("assets/images/icon_calendar.jpg", 'October', '90', 10),
                        cards("assets/images/icon_calendar.jpg", 'November', '22', 11),
                        cards("assets/images/icon_calendar.jpg", 'December', '90', 12),
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
