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
          color: Colors.grey[100],
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
                        cards("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdiWF8Y9ECX_MvZc80eM-zb8qXjMpJ5kiAfMQhoQzZeRjwUOgH6PeGKmqsv-wcbZUgjaw&usqp=CAU", 'DATA', '30', 1),
                        cards("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcResMNRWwEGnmKohXmIz1C8SMGYeBw0z97BO8M8tBqDM4QLUVBiKc1vBSC1ex52L2vg_RY&usqp=CAU", 'RECIPES', '37', 2),
                        cards("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_MHT_T8A7dHCIh9C1gdi1PAq3d-tq0DpjeQ&usqp=CAU", 'ADVICES', '22', 3),
                        cards("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ33OZh9TB2x3HfPvRwlmRBPaHD8VXUefJhKA&usqp=CAU", 'HOSPITAL', '90', 4),
                        cards("https://www.iconbunny.com/icons/media/catalog/product/cache/2/thumbnail/600x/1b89f2fc96fc819c2a7e15c7e545e8a9/6/3/638.7-calendar-icon-iconbunny.jpg", 'CALENDAR', '22', 5),
                        cards("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkw-6xtvGMAI7mhMS0ew-zPLedWxO-JhWqXw&usqp=CAU", 'NEW', '90', 6),
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