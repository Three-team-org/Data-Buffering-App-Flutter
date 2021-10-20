import 'package:data_buffer/ui/sub_recipes.dart';
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
import 'package:data_buffer/database/model/form.dart';
import 'package:data_buffer/database/database_helper.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:data_buffer/ui/widgets/textformfield.dart';
import 'package:data_buffer/ui/widgets/responsive_ui.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class CalendarPage extends StatefulWidget {
  String user_role = "", user_name = "";
  CalendarPage(@required this.user_role, @required this.user_name);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Form_draft form;

  String _picked_water = "WATER ONE";
  String _picked_vit = "Vit. ONE";
  String _picked_hygine = "Morning";
  Color _color = Colors.brown;
  String _hex_color = '0x${Colors.blue.value.toRadixString(16)}';
  String _selected_day_str = DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  TextEditingController _groceries_controller = TextEditingController();
  TextEditingController _reaction_controller = TextEditingController();
  String hint;
  TextEditingController textEditingController;
  TextInputType keyboardType;
  bool obscureText;
  IconData icon;
  double _height;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;
  List<String> _checked_water = [];
  List<String> _checked_vit = [];
  List<String> _checked_hygin = [];

  List<String> _checked_spoon = [];
  GifController controller_gif;

  List<String> _checked_teeth_upper = [];
  List<String> _checked_teeth_lower = [];

  Future addRecord() async {
    var db = new DatabaseHelper();
    String _checked_water_str = _checked_water.join(',');
    String _checked_vit_str = _checked_vit.join(',');
    String _checked_hygin_str = _checked_hygin.join(',');
    String _checked_spoon_str = _checked_spoon.join(',');

    String _checked_teeth_upper_str = _checked_teeth_upper.join(',');
    String _checked_teeth_lower_str = _checked_teeth_lower.join(',');

    var Form = new Form_draft(
        _groceries_controller.text,
        _checked_water_str,
        _checked_vit_str,
        _hex_color,
        _reaction_controller.text,
        _checked_hygin_str,
        _selected_day_str,
        _checked_spoon_str,
        _checked_teeth_upper_str,
        _checked_teeth_lower_str,
        widget.user_role,
        widget.user_name);
    await db.saveUser(Form);
    setState(() {
      _groceries_controller = TextEditingController(text: '');
      _checked_water = [];
      _checked_vit = [];
      Color otherColor = Colors.blue;
      _color = otherColor;
      _reaction_controller = TextEditingController(text: '');
      _checked_hygin = [];
    });
  }

  getRecord(String date) async {
    var db = new DatabaseHelper();
    var maps;
    if (widget.user_role == "admin") {
      maps = await db.getDraft_admin(date, widget.user_role);
    } else {
      maps = await db.getDraft(date, widget.user_role, widget.user_name);
    }
    if (maps.length != 0) {
      String grocery_name_str = maps[maps.length - 1]['grocery_name'];
      String water_type_str = maps[maps.length - 1]['water_type'];
      String vit_type_str = maps[maps.length - 1]['vit_type'];
      String color_str = maps[maps.length - 1]['color'];
      String reaction_str = maps[maps.length - 1]['reaction'];
      String hygiene_str = maps[maps.length - 1]['hygiene'];
      String colorString = color_str.toString(); // Color(0x12345678)
      print(colorString);
      String valueString = colorString.split('0x')[1]; // kind of hacky..
      print(valueString);
      int value = int.parse(valueString, radix: 16);
      String spoon_select_str = maps[maps.length - 1]['spoon_select'];
      String upper_selected_str = maps[maps.length - 1]['upper_selected'];
      String lower_selected_str = maps[maps.length - 1]['lower_selected'];
      setState(() {
        _groceries_controller = TextEditingController(text: grocery_name_str);
        _checked_water = water_type_str.split(',');
        _checked_vit = vit_type_str.split(',');

        Color otherColor = new Color(value);
        _color = otherColor;
        _reaction_controller = TextEditingController(text: reaction_str);
        _checked_hygin = hygiene_str.split(',');
        _checked_spoon = spoon_select_str.split(',');
        _checked_teeth_upper = upper_selected_str.split(',');
        _checked_teeth_lower = lower_selected_str.split(',');
      });
    } else {
      _groceries_controller = TextEditingController(text: '');
      _checked_water = [];
      _checked_vit = [];
      Color otherColor = Colors.blue;
      _color = otherColor;
      _reaction_controller = TextEditingController(text: '');
      _checked_hygin = [];
    }
  }

  @override
  void initState() {
    super.initState();
    getRecord(_selected_day_str);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
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
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Container(
                    height: _height / 2,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/calendar.png',
                              fit: BoxFit.fill,
                              height: _height / 2,
                              width: _width * 0.99,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: _width * 0.9,
                                    height: _height * 0.45,
                                    child: TableCalendar(
                                      rowHeight: _height * 0.05,
                                      firstDay: DateTime.utc(2010, 10, 16),
                                      lastDay: DateTime.utc(2030, 3, 14),
                                      focusedDay: _focusedDay,
                                      selectedDayPredicate: (day) {
                                        return isSameDay(_selectedDay, day);
                                      },
                                      onDaySelected: (selectedDay, focusedDay) {
                                        setState(() {
                                          _selectedDay = selectedDay;

                                          _selected_day_str =
                                              DateFormat("yyyy-MM-dd")
                                                  .format(_selectedDay);
                                          getRecord(_selected_day_str);

                                          _focusedDay = focusedDay;
                                        });
                                      },
                                    ),
                                  )
                                ]),
                          ],
                        )
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total", style: Theme.of(context).textTheme.subtitle1),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => RecipesPage()));
                  },
                  child: Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Text("New Groceries".toUpperCase())),
                ),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  icon: Icons.receipt,
                  hint: "Groceries name",
                  textEditingController: _groceries_controller,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.all(8.0),
                          width: double.infinity,
                          child: Text(
                            "Table Spoon".toUpperCase(),
                            textAlign: TextAlign.left,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            CheckboxGroup(
                              activeColor: Colors.blue,
                              orientation: GroupedButtonsOrientation.HORIZONTAL,
                              margin: const EdgeInsets.only(left: 8.0),
                              padding: const EdgeInsets.all(2),
                              onSelected: (List selected) => setState(() {
                                _checked_spoon = selected;
                              }),
                              labels: <String>[
                                "1",
                                "2",
                                "3",
                                "4",
                                "5",
                                "6",
                                "7",
                              ],
                              checked: _checked_spoon,
                              itemBuilder: (Checkbox cb, Text txt, int i) {
                                return Column(
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.utensilSpoon),
                                    cb,
                                    txt,
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: Text("WATER".toUpperCase())),
                Column(
                  children: <Widget>[
                    CheckboxGroup(
                      orientation: GroupedButtonsOrientation.VERTICAL,
                      activeColor: Colors.blue,
                      margin: const EdgeInsets.only(left: 12.0),
                      onSelected: (List selected) => setState(() {
                        _checked_water = selected;
                        print(_checked_water);
                      }),
                      labels: <String>[
                        "WATER ONE",
                        "WATER TWO",
                      ],
                      checked: _checked_water,
                    ),
                    Container(
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(8.0),
                        width: double.infinity,
                        child: Text("VIT. D".toUpperCase())),
                    CheckboxGroup(
                      orientation: GroupedButtonsOrientation.VERTICAL,
                      activeColor: Colors.blue,
                      margin: const EdgeInsets.only(left: 12.0),
                      onSelected: (List selected) => setState(() {
                        _checked_vit = selected;
                      }),
                      labels: <String>[
                        "Vit. ONE",
                        "Vit. TWO",
                      ],
                      checked: _checked_vit,
                    ),
                    Container(
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(8.0),
                        width: double.infinity,
                        child: Text("Color".toUpperCase())),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Card(
                          elevation: 2,
                          child: ColorPicker(
                            // Use the screenPickerColor as start color.
                            pickersEnabled: const <ColorPickerType, bool>{
                              ColorPickerType.accent: false,
                            },
                            color: _color,
                            // Update the screenPickerColor using the callback.
                            onColorChanged: (Color color) => setState(() {
                              _color = color;
                              _hex_color =
                                  '0x${_color.value.toRadixString(16)}';
                            }),
                            width: 44,
                            height: 44,
                            borderRadius: 22,
                            heading: Text(
                              'Select color',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            subheading: Text(
                              'Select color shade',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: Text("Reaction".toUpperCase())),
                Container(
                  width: _width,
                  child: Material(
                    borderRadius: BorderRadius.circular(30.0),
                    elevation: large ? 12 : (medium ? 10 : 8),
                    child: TextFormField(
                      controller: _reaction_controller,
                      keyboardType: TextInputType.multiline,
                      cursorColor: Colors.orange[200],
                      maxLines: 3,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(icon, color: Colors.orange[200], size: 20),
                        hintText: hint,
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
                    child: Text("Hygiene".toUpperCase())),
                CheckboxGroup(
                  orientation: GroupedButtonsOrientation.VERTICAL,
                  activeColor: Colors.blue,
                  margin: const EdgeInsets.only(left: 12.0),
                  onSelected: (List selected) => setState(() {
                    _checked_hygin = selected;
                  }),
                  labels: <String>[
                    "Morning",
                    "Evening",
                  ],
                  checked: _checked_hygin,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.all(8.0),
                          width: double.infinity,
                          child: Text(
                            "Upper jaw".toUpperCase(),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            CheckboxGroup(
                              activeColor: Colors.blueAccent,
                              orientation: GroupedButtonsOrientation.HORIZONTAL,
                              margin: const EdgeInsets.only(left: 8.0),
                              padding: const EdgeInsets.all(2),
                              onSelected: (List selected) => setState(() {
                                _checked_teeth_upper = selected;
                              }),
                              labels: <String>[
                                "1",
                                "2",
                                "3",
                                "4",
                                "5",
                                "6",
                                "7",
                                "8",
                                "9",
                                "10",
                              ],
                              checked: _checked_teeth_upper,
                              itemBuilder: (Checkbox cb, Text txt, int i) {
                                return Column(
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.tooth),
                                    cb,
                                    txt,
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            CheckboxGroup(
                              activeColor: Colors.blueAccent,
                              orientation: GroupedButtonsOrientation.HORIZONTAL,
                              margin: const EdgeInsets.only(left: 8.0),
                              padding: const EdgeInsets.all(2),
                              onSelected: (List selected) => setState(() {
                                _checked_teeth_lower = selected;
                              }),
                              labels: <String>[
                                "1",
                                "2",
                                "3",
                                "4",
                                "5",
                                "6",
                                "7",
                                "8",
                                "9",
                                "10",
                              ],
                              checked: _checked_teeth_lower,
                              itemBuilder: (Checkbox cb, Text txt, int i) {
                                return Column(
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.tooth),
                                    cb,
                                    txt,
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                          color: Colors.grey.shade200,
                          padding: EdgeInsets.all(8.0),
                          width: double.infinity,
                          child: Text(
                            "Lower jaw".toUpperCase(),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    padding:
                        EdgeInsets.fromLTRB(_width / 3, 10, _width / 3, 10),
                    color: Color(0xFFF46C20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      addRecord();
                      getRecord(_selected_day_str);
                      Toast.show("Saved Successfully!", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
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
