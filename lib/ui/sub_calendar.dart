
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
class CalendarPage extends StatefulWidget{
  @override
  _CalendarPageState createState() => _CalendarPageState();

}

class _CalendarPageState extends State<CalendarPage>{

  String group_water = "group_water";
  String group_vit = "group_vit";
  String group_hygine = "group_hygine";
  String _picked_water = "WATER TWO";
  String _picked_vit = "Vit. ONE";
  String _picked_hygine = "Morning";
  Color _color = Colors.blue;

  List<String> _checked_color;
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
                height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.single,
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                  ),
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
                // controller: myController,
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
                  onPressed: ()=> {},
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

