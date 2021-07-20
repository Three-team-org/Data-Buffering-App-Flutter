
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:table_calendar/table_calendar.dart';
import 'package:data_buffer/ui/widgets/textformfield.dart';
import 'package:data_buffer/ui/widgets/responsive_ui.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:toast/toast.dart';
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
  Color dialogPickerColor;
  Color currentColor = Colors.limeAccent;
  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate;
  TextEditingController timeinput = TextEditingController();
  //text editing controller for text field
  DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  String _selected_day_str = DateFormat("yyyy-MM-dd").format(DateTime.now());
  TextEditingController _doctor_controller = TextEditingController();
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;
  List<String> color_list =  List.filled(20, "${Colors.white.value.toRadixString(16)}");
  Widget bigCircle = new Container(
    width: 300.0,
    height: 300.0,
    decoration: new BoxDecoration(
      color: Colors.orange,
      shape: BoxShape.circle,
    ),
  );
  void changeColor(Color color) => setState(() => currentColor = color);
  @override
  void initState() {
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    Color _colors = new Color(20);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text("Hospital Page", style: TextStyle(color: Colors.white, fontSize: 25),),
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

                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _selected_day_str = DateFormat("yyyy-MM-dd").format(_selectedDay);
                    _focusedDay = focusedDay;

                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: <Widget>[
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("Doctor name".toUpperCase())
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    icon: Icons.receipt,
                    hint: "Doctor name",
                    textEditingController: _doctor_controller,
                  ),
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("Dentist name".toUpperCase())
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    icon: Icons.receipt,
                    hint: "Dentist name",
                    textEditingController: _doctor_controller,
                  ),
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("Weight ".toUpperCase())
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    icon: Icons.receipt,
                    hint: "Your Weight",
                    // textEditingController: _doctor_controller,
                  ),
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("Length".toUpperCase())
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    icon: Icons.receipt,
                    hint: "Your Length",
                    // textEditingController: _doctor_controller,
                  ),
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("Advice".toUpperCase())
                  ),
                  Container(
                    child:
                    Material(
                      borderRadius: BorderRadius.circular(30.0),
                      elevation: large? 12 : (medium? 10 : 8),
                      child: TextFormField(
                        // controller: _reaction_controller,
                        keyboardType: TextInputType.multiline,
                        cursorColor: Colors.orange[200],
                        maxLines: 3,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.input, color: Colors.orange[200], size: 20),
                          hintText: "Advice...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("Remarks".toUpperCase())
                  ),
                  Container(
                    child:
                    Material(
                      borderRadius: BorderRadius.circular(30.0),
                      elevation: large? 12 : (medium? 10 : 8),
                      child: TextFormField(
                        // controller: _reaction_controller,
                        keyboardType: TextInputType.multiline,
                        cursorColor: Colors.orange[200],
                        maxLines: 3,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.input, color: Colors.orange[200], size: 20),
                          hintText: "Remarks...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 20,),
          // Material(
          //   color: Colors.grey[50],
          //   child: new Center(
          //     child: new Stack(
          //       children: <Widget>[
          //         bigCircle,
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[0], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () async{
          //               final Color colorBeforeDialog = Colors.white;
          //               // Wait for the picker to close, if dialog was dismissed,
          //               // then restore the color we had before it was opened.
          //               if (!(await colorPickerDialog())) {
          //                 setState(() {
          //                   dialogPickerColor = colorBeforeDialog;
          //                 });
          //               }
          //             },
          //           ),
          //           top: 0,
          //           left: 120.0,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[1], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           top: 9,
          //           left: 155.3,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[2], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           top: 25,
          //           left: 190.4,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[3], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           top: 50,
          //           left: 215.9,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[4], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //
          //           top: 80,
          //           left: 233.1,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               shape: CircleBorder(),
          //               primary: new Color(int.parse(color_list[5], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //               onPressed: () {},
          //           ),
          //           top: 120.0,
          //           left: 0.0,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[6], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           top: 9,
          //           right: 155.3,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[7], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           top: 25,
          //           right: 190.4,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[8], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           top: 50,
          //           right: 215.9,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[9], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //
          //           top: 80,
          //           right: 233.1,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[10], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           top: 120.0,
          //           right: 0.0,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[11], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           bottom: 9,
          //           left: 155.3,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[12], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           bottom: 25,
          //           left: 190.4,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[13], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           bottom: 50,
          //           left: 215.9,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[14], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //
          //           bottom: 80,
          //           left: 233.1,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[15], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           top: 250.0,
          //           left: 120.0,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[16], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           bottom: 9,
          //           right: 155.3,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[17], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           bottom: 25,
          //           right: 190.4,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[18], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //           bottom: 50,
          //           right: 215.9,
          //         ),
          //         new Positioned(
          //           child: new ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 shape: CircleBorder(),
          //                 primary: new Color(int.parse(color_list[19], radix: 16))
          //             ),
          //             child: Container(
          //               width: 8,
          //               height: 8,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(shape: BoxShape.circle),
          //               child: Container(),
          //             ),
          //             onPressed: () {},
          //           ),
          //
          //           bottom: 80,
          //           right: 233.1,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
            SizedBox(height: 30,),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.red,
                onPressed: (){

                  Toast.show("Saved Successfully!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                },
                child: Text("Confirm", style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),
          ]
          ),
      ),
    );
  }
  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyText2,
      colorCodePrefixStyle: Theme.of(context).textTheme.caption,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },

    ).showPickerDialog(
      context,
      constraints:
      const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 25.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}