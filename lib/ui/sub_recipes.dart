import 'package:data_buffer/services/theme_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:data_buffer/ui/sub_recipe_month_page.dart';
import 'package:data_buffer/ui/widgets/customappbar.dart';

class RecipesPage extends StatefulWidget {
  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _RecipesPageState extends State<RecipesPage> {
  ThemeService themeService = ThemeService();
  double _height;
  double _width;
  Widget cards(image, title, price, page_num) {
    String str_recipes_months = "";
    String str_month_name = "";
    return GestureDetector(
      onTap: () {
        switch (page_num) {
          case 1:
            str_recipes_months = "This recipe is for 1 month";
            str_month_name = "1 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 2:
            str_recipes_months = "This recipe is for 2 month";
            str_month_name = "2 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 3:
            str_recipes_months = "This recipe is for 3 month";
            str_month_name = "3 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 4:
            str_recipes_months = "This recipe is for 4 month";
            str_month_name = "4 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 5:
            str_recipes_months = "This recipe is for 5 month";
            str_month_name = "5 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 6:
            str_recipes_months = "This recipe is for 6 month";
            str_month_name = "6 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 7:
            str_recipes_months = "This recipe is for 7 month";
            str_month_name = "7 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 8:
            str_recipes_months = "This recipe is for 8 month";
            str_month_name = "8 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 9:
            str_recipes_months = "This recipe is for 9 month";
            str_month_name = "9 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 10:
            str_recipes_months = "This recipe is for 10 month";
            str_month_name = "10 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 11:
            str_recipes_months = "This recipe is for 11 month";
            str_month_name = "11 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
          case 12:
            str_recipes_months = "This recipe is for 12 month";
            str_month_name = "12 month";
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    RecipeMonthPage(str_recipes_months, str_month_name)));
            break;
        }
      },
      child: Container(
        // height: 200,
        // width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
                height: _width * 0.4,
                width: _width * 0.4,
              ),
              SizedBox(
                height: 1,
              ),
              Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 1,
                    color: Colors.orangeAccent.shade200,
                  )),
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
        // appBar: AppBar(
        //   title: Text("RECIPE PAGE",style: TextStyle(color: Colors.white, fontSize: 25),),
        //   backgroundColor: Colors.red,
        //   elevation: 0,
        // ),
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
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          Spacer(),
                          Text("RECIPE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                          Spacer(),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
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
                    cards("assets/images/recipe_1.png", '1 Month', '37', 1),
                    cards("assets/images/recipe_2.png", '2 Month', '22', 2),
                    cards("assets/images/recipe_3.png", '3 Month', '90', 3),
                    cards("assets/images/recipe_4.png", '4 Month', '22', 4),
                    cards("assets/images/recipe_5.png", '5 Month', '90', 5),
                    cards("assets/images/recipe_6.png", '6 Month', '30', 6),
                    cards("assets/images/recipe_7.png", '7 Month', '37', 7),
                    cards("assets/images/recipe_8.png", '8 Month', '22', 8),
                    cards("assets/images/recipe_9.png", '9 Month', '90', 9),
                    cards("assets/images/recipe_10.png", '10 Month', '22', 10),
                    cards("assets/images/recipe_11.png", '11 Month', '22', 11),
                    cards("assets/images/recipe_12.png", '12 Month', '90', 12),
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
