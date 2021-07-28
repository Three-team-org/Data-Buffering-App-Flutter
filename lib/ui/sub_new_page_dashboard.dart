import 'package:data_buffer/ui/sub_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:data_buffer/ui/sub_data.dart';
import 'package:data_buffer/ui/sub_recipes.dart';
import 'package:data_buffer/ui/sub_advices.dart';
import 'package:data_buffer/ui/sub_hospital.dart';
import 'package:data_buffer/ui/sub_calendar.dart';
import 'package:data_buffer/ui/widgets/network_image.dart';

class NewPageDashboardScreen extends StatefulWidget{
  @override
  _NewPageDashboardScreenState createState() => _NewPageDashboardScreenState();

}
class _NewPageDashboardScreenState extends State<NewPageDashboardScreen>{
  final TextStyle whiteText = TextStyle(color: Colors.white);

  Widget cards(image, title, price, page_num) {
    return GestureDetector(
      onTap: (){
        switch(page_num){
          case 1:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => NewPage()));
            break;
          case 2:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => NewPage()));
            break;
          case 3:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => NewPage()));
            break;
          case 4:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => NewPage()));
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
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 1,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_today),
      //       title: Text("Today's Special"),
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.fastfood,
      //           color: Colors.deepOrange,
      //         ),
      //         title: Text(
      //           "Foods",
      //           style: TextStyle(color: Colors.deepOrange),
      //         )),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.settings), title: Text("Settings")),
      //   ],
      // ),
        backgroundColor: Colors.white70.withOpacity(0.9),
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
                              Text("NEW PAGE",
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
                        cards("assets/images/15_border.png", 'DAYS', '30', 1),
                        cards("assets/images/20.png", 'DAYS', '37', 2),
                        cards("assets/images/check.png", 'YES', '22', 3),
                        cards("assets/images/cross.png", 'NO', '90', 4),

                      ],
                    ),
                  ),

                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 500.0),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tellus justo, "
                        "venenatis pretium urna posuere, malesuada tempus lectus. Curabitur molestie efficitur eros,"
                        " eu sodales elit malesuada eu. Nunc auctor consequat tincidunt. Sed id mi a dui scelerisque "
                ),
              ),
            ],
          ),
        ));
  }

}