
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HospitalPage extends StatefulWidget{
  @override
  _HospitalPageState createState() => _HospitalPageState();

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _HospitalPageState extends State<HospitalPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Hospital Page", style: TextStyle(color: Colors.blueAccent, fontSize: 25),),
        automaticallyImplyLeading: false,
        actions: <Widget>[

          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black54,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(),
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tellus justo, "
                      "venenatis pretium urna posuere, malesuada tempus lectus. Curabitur molestie efficitur eros,"
                      " eu sodales elit malesuada eu. Nunc auctor consequat tincidunt. Sed id mi a dui scelerisque "
                      ),
            ),
            _buildTitle("ADVICES"),

            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tellus justo, "
                      "venenatis pretium urna posuere, malesuada tempus lectus. Curabitur molestie efficitur eros,"
                      " eu sodales elit malesuada eu. Nunc auctor consequat tincidunt. Sed id mi a dui scelerisque "
              ),
            ),
            SizedBox(height: 30.0),
            _buildTitle("REMARKS/ANNOTATIONS"),
            _buildExperienceRow(
                company: "REMARK 1",
                position: "Description",
                duration: "2010 - 2012"),
            _buildExperienceRow(
                company: "REMARK 2",
                position: "Description",
                duration: "2010 - 2012"),
            _buildExperienceRow(
                company: "REMARK 3",
                position: "Description",
                duration: "2010 - 2012"),

            SizedBox(height: 20.0),

          ],
        ),
      ),
    );
  }
  Row _buildSocialsRow() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20.0),
        IconButton(
          color: Colors.indigo,
          icon: Icon(FontAwesomeIcons.facebookF),
          onPressed: () {

          },
        ),
        SizedBox(width: 5.0),
        IconButton(
          color: Colors.indigo,
          icon: Icon(FontAwesomeIcons.github),
          onPressed: () {

          },
        ),
        SizedBox(width: 5.0),
        IconButton(
          color: Colors.red,
          icon: Icon(FontAwesomeIcons.youtube),
          onPressed: () {
          },
        ),
        SizedBox(width: 10.0),
      ],
    );
  }

  ListTile _buildExperienceRow(
      {String company, String position, String duration}) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 20.0),
        child: Icon(
          FontAwesomeIcons.solidCircle,
          size: 12.0,
          color: Colors.black54,
        ),
      ),
      title: Text(
        company,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text("$position ($duration)"),
    );
  }

  Row _buildSkillRow(String skill, double level) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16.0),
        Expanded(
            flex: 2,
            child: Text(
              skill.toUpperCase(),
              textAlign: TextAlign.right,
            )),
        SizedBox(width: 10.0),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: level,
          ),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20.0),
        Container(
            width: 80.0,
            height: 80.0,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                    radius: 35.0, backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ4UHTr3Igbzm0b_2a0zH1DDxguhkeu7wDZA&usqp=CAU")))),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Doctor Name...",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.calendarDay,
                  size: 12.0,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "DATE: ",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.businessTime,
                  size: 12.0,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "TIME: ",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

