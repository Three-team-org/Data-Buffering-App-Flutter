
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:data_buffer/ui/widgets/primary_button.dart';

class CalendarPage extends StatefulWidget{
  @override
  _CalendarPageState createState() => _CalendarPageState();

}


class _CalendarPageState extends State<CalendarPage>{

  final String address = "Some text";
  final String phone="Some text";
  final double total = 500;
  final double delivery = 100;

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
                  child: Text("WATER".toUpperCase())
              ),
              Column(
                children: <Widget>[
                  RadioListTile(
                    selected: true,
                    value: address,
                    groupValue: address,
                    title: Text(address),
                    onChanged: (value){},
                  ),
                  RadioListTile(
                    selected: false,
                    value: "New Address",
                    groupValue: address,
                    title: Text("Some text..."),
                    onChanged: (value){},
                  ),
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("VIT. D".toUpperCase())
                  ),
                  RadioListTile(
                    selected: true,
                    value: "Some text...",
                    groupValue: phone,
                    title: Text(phone),
                    onChanged: (value){},
                  ),
                  RadioListTile(
                    selected: false,
                    value: "COLOR",
                    groupValue: phone,
                    title: Text("Some text..."),
                    onChanged: (value){},
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text("REACTION".toUpperCase())
              ),
              TextFormField(

                style: TextStyle(fontSize: 18.0),
              ),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text("HYGINE".toUpperCase())
              ),
              RadioListTile(
                groupValue: true,
                value: true,
                title: Text("MORNING"),
                onChanged: (value){},
              ),
              RadioListTile(
                groupValue: true,
                value: true,
                title: Text("EVENING"),
                onChanged: (value){},
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