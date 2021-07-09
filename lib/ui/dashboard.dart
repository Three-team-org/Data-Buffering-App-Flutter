import 'package:data_buffer/ui/sub_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:data_buffer/ui/sub_data.dart';
import 'package:data_buffer/ui/sub_recipes.dart';
import 'package:data_buffer/ui/sub_advices.dart';
import 'package:data_buffer/ui/sub_hospital.dart';

class DashboardScreen extends StatefulWidget{
  @override
  _DashboardScreenState createState() => _DashboardScreenState();

}
class _DashboardScreenState extends State<DashboardScreen>{
  final TextStyle whiteText = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 40.0),
          _buildHeader(),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "DASHBOARD",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _buildTile(
                    color: Colors.pink,
                    icon: FontAwesomeIcons.database,
                    title: "DATA",
                    data: "1200",
                    screen_num: 1,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.green,
                    icon: FontAwesomeIcons.receipt,
                    title: "RECIPES",
                    data: "857",
                    screen_num: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildTile(
                    color: Colors.blue,
                    icon: FontAwesomeIcons.speakerDeck,
                    title: "ADVICES",
                    data: "864",
                    screen_num: 3,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.pink,
                    icon: FontAwesomeIcons.hospital,
                    title: "HOSPITAL",
                    data: "857",
                    screen_num: 4,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.blue,
                    icon: FontAwesomeIcons.calendarWeek,
                    title: "CALENDAR",
                    data: "698",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NewPage()));
        },
        tooltip: 'Increment',
        child: Icon(
          FontAwesomeIcons.userPlus,
        ),
      ),
    );

  }
  Container _buildHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Dr. John Doe",
              style: whiteText.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Md, (General Medium), DM(Cardiology)",
              style: whiteText.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildTile(
      {Color color, IconData icon, String title, String data, int screen_num}) {
    return GestureDetector(
        onTap: (){
          switch(screen_num){
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
          }

        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                title,
                style: whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                data,
                style:
                whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
              ),
            ],
          ),
        ),
    );

  }

}