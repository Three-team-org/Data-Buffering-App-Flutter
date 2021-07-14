
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:data_buffer/ui/widgets/primary_button.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:data_buffer/ui/widgets/custom_color_picker.dart';
import 'package:data_buffer/database/model/form.dart';
import 'package:data_buffer/database/database_helper.dart';
import 'package:table_calendar/table_calendar.dart';
class CalendarPage extends StatefulWidget{
  @override
  _CalendarPageState createState() => _CalendarPageState();

}

class _CalendarPageState extends State<CalendarPage>{

  Form_draft form;

  String _picked_water = "WATER TWO";
  String _picked_vit = "Vit. ONE";
  String _picked_hygine = "Morning";
  Color _color = Colors.blue;
  String _selected_day_str;
  DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  TextEditingController _groceries_controller = TextEditingController();
  TextEditingController _reaction_controller = TextEditingController();

  Future addRecord() async {
    var db = new DatabaseHelper();
    var Form = new Form_draft(_groceries_controller.text, _picked_water,_picked_vit, _color.toString(),
        _reaction_controller.text, _picked_hygine, _selected_day_str,
        );
    await db.saveUser(Form);

  }
  getRecord(String date) async {
    var db = new DatabaseHelper();
    var maps = await db.getDraft(date);

    print(maps[0]['grocery_name'] );
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            FlutterIcons.keyboard_backspace_mdi,
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
        title: Text(
          "CALENDAR PAGE",
          style: TextStyle(
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Container(
                height: 350.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;

                      _selected_day_str = DateFormat("yyyy-MM-dd").format(_selectedDay);
                      getRecord(_selected_day_str);
                      print(_selected_day_str);
                      _focusedDay = focusedDay;

                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total", style: Theme.of(context).textTheme.title,),

                ],
              ),
              SizedBox(height: 20.0,),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text("New Groceries".toUpperCase())
              ),
              TextFormField(
                controller: _groceries_controller,
                style: TextStyle(fontSize: 18.0),
              ),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text("WATER".toUpperCase())
              ),
              Column(
                children: <Widget>[
                  RadioButtonGroup(
                  orientation: GroupedButtonsOrientation.VERTICAL,
                    margin: const EdgeInsets.only(left: 12.0),
                    onSelected: (String selected) => setState((){
                      print(selected);
                      _picked_water = selected;
                    }),
                    labels: <String>[
                      "WATER ONE",
                      "WATER TWO",
                    ],
                    picked: _picked_water,

                  ),
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("VIT. D".toUpperCase())
                  ),
                  RadioButtonGroup(
                    orientation: GroupedButtonsOrientation.VERTICAL,
                    margin: const EdgeInsets.only(left: 12.0),
                    onSelected: (String selected) => setState((){
                      print(selected);
                      _picked_vit = selected;
                    }),
                    labels: <String>[
                      "Vit. ONE",
                      "Vit. TWO",
                    ],
                    picked: _picked_vit,
                  ),
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("Color".toUpperCase())
                  ),
                  MyColorPicker(
                      onSelectColor: (value) {
                        setState(() {
                          _color = value;
                        });
                      },
                      availableColors: [
                        Colors.blue,
                        Colors.lightBlue,
                        Colors.orange,
                        Colors.red,
                        Colors.purple,
                        Colors.grey,
                        Colors.teal
                      ],
                      initialColor: _color)
                ],
              ),
              SizedBox(height: 20.0,),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text("Reaction".toUpperCase())
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                controller: _reaction_controller,
              ),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text("Hygine".toUpperCase())
              ),
              RadioButtonGroup(
                orientation: GroupedButtonsOrientation.VERTICAL,
                margin: const EdgeInsets.only(left: 12.0),
                onSelected: (String selected) => setState((){
                  print(selected);
                  _picked_hygine = selected;
                }),
                labels: <String>[
                  "Morning",
                  "Evening",
                ],
                picked: _picked_hygine,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    addRecord();
                  },
                  child: Text("Confirm", style: TextStyle(
                      color: Colors.white
                  ),),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

