
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DataPage extends StatefulWidget{
  @override
  _DataPageState createState() => _DataPageState();

}

class _DataPageState extends State<DataPage>{

  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text("DATA PAGE"),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.5, 0.9],
                    colors: [Colors.red, Colors.deepOrange.shade300])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 13,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    CircleAvatar(
                      minRadius: 60,
                      backgroundColor: Colors.deepOrange.shade300,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("https://cdn.icon-icons.com/icons2/2643/PNG/512/male_man_people_person_avatar_white_tone_icon_159363.png"),
                        minRadius: 50,
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "User Name",
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                Text(
                  "Address",
                  style: TextStyle(fontSize: 14.0, color: Colors.red.shade700),
                )
              ],
            ),
          ),
          ListTile(
            title: Text(
              "FULL NAME",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: TextFormField(

              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "BIRTHDAY",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: Container(
              width: 150,
              padding: EdgeInsets.all(8.0),
              child: TextField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: _dateController,
                onTap: () {
                  _selectDate(context);
                },
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "Twitter",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: Text(
              "@ramkumar",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "Facebook",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: Text(
              "facebook.com/ramkumar",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _dateController
        ..text = DateFormat.yMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
