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

class DashboardScreen extends StatefulWidget{
  @override
  _DashboardScreenState createState() => _DashboardScreenState();

}
class _DashboardScreenState extends State<DashboardScreen>{
  final TextStyle whiteText = TextStyle(color: Colors.white);

  Widget cards(image, title, price, page_num) {
    return GestureDetector(
      onTap: (){
          switch(page_num){
            case 1:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => DataPage()));
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => RecipesPage()));
              break;
            case 3:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => AdvicesPage()));
              break;
            case 4:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => HospitalPage()));
              break;
            case 5:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => CalendarPage()));
              break;
            case 6:
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
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PNetworkImage(
                image,
                height: 80,
              ),
              SizedBox(
                height: 10,
              ),
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                  color: Colors.blueAccent.shade700,
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
                          Text("MY DASHBOARD",
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),

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
                        cards("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdxrQu01qxumDHoBO_zODO670lIX05Kajlaw&usqp=CAU", 'DATA', '30', 1),
                        cards("https://images.unsplash.com/photo-1542010589005-d1eacc3918f2?ixid=MnwxMjA"
                            "3fDB8MHxzZWFyY2h8MXx8cmVjaXBlc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80", 'RECIPES', '37', 2),
                        cards("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPdyinzKIVsQbbZclbNtG098Iu0f700mmTQA&usqp=CAU", 'ADVICES', '22', 3),
                        cards("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1_hYpvoB_9-nKpbHbazxs3hmiawAlbvLgJg&usqp=CAU", 'HOSPITAL', '90', 4),
                        cards("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGS1LgXBdnQ-ZoTuJ8PZby_J5iAsnjnXlm7Q&usqp=CAU", 'CALENDAR', '22', 5),
                        cards("https://cdn0.iconfinder.com/data/icons/interface-10/128/_add_image-512.png", 'NEW', '90', 6),
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