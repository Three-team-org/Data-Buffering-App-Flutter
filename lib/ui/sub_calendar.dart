import 'package:data_buffer/services/theme_service.dart';
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
import 'package:data_buffer/ui/widgets/customappbar.dart';

class CalendarPage extends StatefulWidget {
  String user_role = "", user_name = "";
  CalendarPage(@required this.user_role, @required this.user_name);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  ThemeService themeService = ThemeService();
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
  List<Color> _spoonColors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  List<Color> _waterColors = [
    Colors.white,
    Colors.white,
  ];
  List<String> _waterLabels = [
    "Water one".toUpperCase(),
    "Water two".toUpperCase(),
  ];

  List<Color> _hyginColors = [
    Colors.white,
    Colors.white,
  ];
  List<String> _hyginLabels = [
    "Morning",
    "Evening",
  ];
  List<Color> _teethUperColors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  List<String> _teethUperLabels = [
    "16",
    "17",
    "18",
    "19",
    "20",
    "1",
    "2",
    "3",
    "4",
    "5"
  ];
  List<Color> _teethLowerColors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];
  List<String> _teethLowerLabels = [
    "15",
    "14",
    "13",
    "12",
    "11",
    "10",
    "9",
    "8",
    "7",
    "6"
  ];
  List<Color> _vit_dColors = [Colors.white];
  List<String> _vit_dLabels = ["Vit.ONE"];

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
    print(_checked_teeth_upper_str + "************");
    await db.saveUser(Form);
    setState(() {
      _groceries_controller = TextEditingController(text: '');
      _checked_water = [];
      _checked_vit = [];
      Color otherColor = Colors.blue;
      _color = otherColor;
      _reaction_controller = TextEditingController(text: '');
      _checked_hygin = [];

      initCheckLabels();
    });
  }

  initCheckLabels() {
    setState(() {
      _spoonColors = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white
      ];

      _waterColors = [
        Colors.white,
        Colors.white,
      ];

      _hyginColors = [
        Colors.white,
        Colors.white,
      ];

      _teethUperColors = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white
      ];

      _teethLowerColors = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white
      ];

      _vit_dColors = [Colors.white];
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
    print(maps);
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

        print(_checked_water);
        for (var i = 1; i <= 7; i++) {
          _checked_spoon.forEach((spoon) {
            if (i.toString() == spoon) {
              print(i);
              _spoonColors[i - 1] = Colors.green;
            }
          });
        }
        _checked_water.forEach((water) {
          if (water == "Water one".toUpperCase()) {
            _waterColors[0] = Colors.green;
          } else if (water == "water two".toUpperCase()) {
            _waterColors[1] = Colors.green;
          } else if (water == "Water one".toUpperCase() &&
              water == "Water two".toUpperCase()) {
            _waterColors[0] = Colors.green;
            _waterColors[1] = Colors.green;
          }
        });
        _checked_vit.forEach((vit) {
          if (vit == "Vit.ONE") {
            _vit_dColors[0] = Colors.green;
          }
        });
        _checked_hygin.forEach((hygin) {
          if (hygin == "Morning") {
            _hyginColors[0] = Colors.green;
          } else if (hygin == "Evening") {
            _hyginColors[1] = Colors.green;
          } else if (hygin == "Morning" && hygin == "Evening") {
            _hyginColors[0] = Colors.green;
            _hyginColors[1] = Colors.green;
          }
        });
        for (var i = 1; i <= 5; i++) {
          _checked_teeth_upper.forEach((upper_teeth) {
            if ((i + 15).toString() == upper_teeth) {
              print(i);
              _teethUperColors[i - 1] = Colors.green;
            }
            if (i.toString() == upper_teeth) {
              print(i);
              _teethUperColors[i + 4] = Colors.green;
            }
          });
        }
        for (var i = 1; i <= 10; i++) {
          _checked_teeth_lower.forEach((lower_teeth) {
            if ((16 - i).toString() == lower_teeth) {
              print(i);
              _teethLowerColors[i - 1] = Colors.green;
            }
          });
        }
      });
    } else {
      setState(() {
        _groceries_controller = TextEditingController(text: '');
        _checked_water = [];
        _checked_vit = [];
        Color otherColor = Colors.blue;
        _color = otherColor;
        _reaction_controller = TextEditingController(text: '');
        _checked_hygin = [];
        _checked_spoon = [];
        initCheckLabels();
      });
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
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color(themeService.myColor1),
                  Color(themeService.myColor2),
                ])),
            child: ListView(
              children: <Widget>[
                Container(
                  height: _height / 5,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Opacity(
                            opacity: 1,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                print("pop");
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "GRADUAL INTRODUCTION\n OF FOODSTUFFS"
                                .toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _width / 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: _height * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: _height / 30,
                    right: 5,
                    bottom: _height / 30,
                    left: 5,
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            width: _width * 0.9,
                                            height: _height * 0.45,
                                            child: TableCalendar(
                                              rowHeight: _height * 0.05,
                                              firstDay:
                                                  DateTime.utc(2010, 10, 16),
                                              lastDay:
                                                  DateTime.utc(2030, 3, 14),
                                              focusedDay: _focusedDay,
                                              selectedDayPredicate: (day) {
                                                return isSameDay(
                                                    _selectedDay, day);
                                              },
                                              onDaySelected:
                                                  (selectedDay, focusedDay) {
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
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ListTile(
                            title: Text(
                              "New Groceries".toUpperCase(),
                              style: TextStyle(
                                  color: Color(themeService.myColor2),
                                  fontSize: 15.0),
                            ),
                            subtitle: CustomTextField(
                              textEditingController: _groceries_controller,
                              keyboardType: TextInputType.text,
                              icon: Icons.receipt,
                              hint: "Groceries name",
                            ),
                          ),
                          Divider(),
                          Container(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    "Table spoon".toUpperCase(),
                                    style: TextStyle(
                                        color: Color(themeService.myColor2),
                                        fontSize: 15.0),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10),
                                  child: Row(
                                    children: <Widget>[
                                      for (var i = 1; i <= 7; i++)
                                        GestureDetector(
                                          onTap: () => setState(() {
                                            if (_spoonColors[i - 1] ==
                                                Colors.green) {
                                              _spoonColors[i - 1] =
                                                  Colors.white;
                                              _checked_spoon
                                                  .remove(i.toString());
                                            } else {
                                              _spoonColors[i - 1] =
                                                  Colors.green;
                                              _checked_spoon.add(i.toString());
                                            }
                                            print(_checked_spoon);
                                          }),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: _width / 9,
                                            margin: EdgeInsets.only(right: 3),
                                            child: CircleAvatar(
                                              radius: 15.0,
                                              backgroundColor:
                                                  _spoonColors[i - 1],
                                              backgroundImage: ExactAssetImage(
                                                  'assets/images/spoon.png'),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              "Water".toUpperCase(),
                              style: TextStyle(
                                  color: Color(themeService.myColor2),
                                  fontSize: 15.0),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 24),
                                child: Column(
                                  children: <Widget>[
                                    for (var i = 1; i <= 2; i++)
                                      GestureDetector(
                                          onTap: () => setState(() {
                                                if (_waterColors[i - 1] ==
                                                    Colors.green) {
                                                  _waterColors[i - 1] =
                                                      Colors.white;
                                                  _checked_water.remove(
                                                      _waterLabels[i - 1]);
                                                } else {
                                                  _waterColors[i - 1] =
                                                      Colors.green;
                                                  _checked_water
                                                      .add(_waterLabels[i - 1]);
                                                }
                                                print(_checked_water);
                                              }),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.center,
                                                width: _width / 9,
                                                margin: EdgeInsets.only(
                                                    right: 3, top: 3),
                                                child: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundColor:
                                                      _waterColors[i - 1],
                                                  backgroundImage: ExactAssetImage(
                                                      'assets/images/glass.png'),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 12),
                                                child:
                                                    Text(_waterLabels[i - 1]),
                                              )
                                            ],
                                          )),
                                  ],
                                ),
                              ),
                              Divider(),
                              ListTile(
                                title: Text(
                                  "Vit. d".toUpperCase(),
                                  style: TextStyle(
                                      color: Color(themeService.myColor2),
                                      fontSize: 15.0),
                                ),
                              ),
                              Column(children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 24),
                                  child: Column(
                                    children: <Widget>[
                                      for (var i = 1; i < 2; i++)
                                        GestureDetector(
                                          onTap: () => setState(() {
                                            if (_vit_dColors[i - 1] ==
                                                Colors.green) {
                                              _vit_dColors[i - 1] =
                                                  Colors.white;
                                              _checked_vit
                                                  .remove(_vit_dLabels[i - 1]);
                                            } else {
                                              _vit_dColors[i - 1] =
                                                  Colors.green;
                                              _checked_vit
                                                  .add(_vit_dLabels[i - 1]);
                                            }
                                            print(_checked_vit);
                                          }),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.center,
                                                width: _width / 9,
                                                margin: EdgeInsets.only(
                                                    right: 3, top: 3),
                                                child: CircleAvatar(
                                                  radius: 20.0,
                                                  backgroundColor:
                                                      _vit_dColors[i - 1],
                                                  backgroundImage: ExactAssetImage(
                                                      'assets/images/vit_d.png'),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 12),
                                                child:
                                                    Text(_vit_dLabels[i - 1]),
                                              )
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              ]),
                              Divider(),
                              ListTile(
                                title: Text(
                                  "Color".toUpperCase(),
                                  style: TextStyle(
                                      color: Color(themeService.myColor2),
                                      fontSize: 15.0),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    // elevation: 2,
                                    child: ColorPicker(
                                      // Use the screenPickerColor as start color.
                                      pickersEnabled: const <ColorPickerType,
                                          bool>{
                                        ColorPickerType.accent: false,
                                      },
                                      color: _color,
                                      // Update the screenPickerColor using the callback.
                                      onColorChanged: (Color color) =>
                                          setState(() {
                                        _color = color;
                                        _hex_color =
                                            '0x${_color.value.toRadixString(16)}';
                                      }),
                                      width: 44,
                                      height: 44,
                                      borderRadius: 22,
                                      heading: Text(
                                        'Select color',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      subheading: Text(
                                        'Select color shade',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              "Reaction".toUpperCase(),
                              style: TextStyle(
                                  color: Color(themeService.myColor2),
                                  fontSize: 15.0),
                            ),
                          ),
                          Container(
                            width: _width,
                            padding: EdgeInsets.only(left: _width / 28),
                            child: Material(
                              borderRadius: BorderRadius.circular(30.0),
                              elevation: large ? 12 : (medium ? 10 : 8),
                              child: TextFormField(
                                controller: _reaction_controller,
                                keyboardType: TextInputType.multiline,
                                cursorColor: Color(themeService.myColor2),
                                maxLines: 3,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.receipt,
                                      color: Color(themeService.myColor2),
                                      size: 20),
                                  hintText: hint,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              "Hygiene".toUpperCase(),
                              style: TextStyle(
                                  color: Color(themeService.myColor2),
                                  fontSize: 15.0),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10, left: 24),
                            child: Column(
                              children: <Widget>[
                                for (var i = 1; i <= 2; i++)
                                  GestureDetector(
                                      onTap: () => setState(() {
                                            if (_hyginColors[i - 1] ==
                                                Colors.green) {
                                              _hyginColors[i - 1] =
                                                  Colors.white;
                                              _checked_hygin
                                                  .remove(_hyginLabels[i - 1]);
                                            } else {
                                              _hyginColors[i - 1] =
                                                  Colors.green;
                                              _checked_hygin
                                                  .add(_hyginLabels[i - 1]);
                                            }
                                            print(_checked_hygin);
                                          }),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.center,
                                            width: _width / 9,
                                            margin: EdgeInsets.only(
                                                right: 3, top: 3),
                                            child: CircleAvatar(
                                              radius: 20.0,
                                              backgroundColor:
                                                  _hyginColors[i - 1],
                                              backgroundImage: ExactAssetImage(
                                                  'assets/images/toothbrush.png'),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 12),
                                            child: Text(_hyginLabels[i - 1]),
                                          )
                                        ],
                                      )),
                              ],
                            ),
                          ),
                          Divider(),
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
                                    style: TextStyle(
                                      color: Color(themeService.myColor2),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      for (var i = 1; i <= 10; i++)
                                        GestureDetector(
                                          onTap: () => setState(() {
                                            if (_teethUperColors[i - 1] ==
                                                Colors.green) {
                                              _teethUperColors[i - 1] =
                                                  Colors.white;
                                              _checked_teeth_upper.remove(
                                                  _teethUperLabels[i - 1]);
                                            } else {
                                              _teethUperColors[i - 1] =
                                                  Colors.green;
                                              _checked_teeth_upper
                                                  .add(_teethUperLabels[i - 1]);
                                            }
                                            print(_checked_teeth_upper);
                                          }),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: _width / 13,
                                            margin: EdgeInsets.only(right: 3),
                                            child: CircleAvatar(
                                              radius: 15.0,
                                              backgroundColor:
                                                  _teethUperColors[i - 1],
                                              backgroundImage: ExactAssetImage(
                                                  'assets/images/t${i}.png'),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      for (var i = 1; i <= 10; i++)
                                        GestureDetector(
                                          onTap: () => setState(() {
                                            if (_teethLowerColors[i - 1] ==
                                                Colors.green) {
                                              _teethLowerColors[i - 1] =
                                                  Colors.white;
                                              _checked_teeth_lower.remove(
                                                  _teethLowerLabels[i - 1]);
                                            } else {
                                              _teethLowerColors[i - 1] =
                                                  Colors.green;
                                              _checked_teeth_lower.add(
                                                  _teethLowerLabels[i - 1]);
                                            }
                                            print(_checked_teeth_lower);
                                          }),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: _width / 13,
                                            margin: EdgeInsets.only(right: 3),
                                            child: CircleAvatar(
                                              radius: 15.0,
                                              backgroundColor:
                                                  _teethLowerColors[i - 1],
                                              backgroundImage: ExactAssetImage(
                                                  'assets/images/t${i + 10}.png'),
                                            ),
                                          ),
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
                                    color: Colors.grey.shade200,
                                    padding: EdgeInsets.all(8.0),
                                    width: double.infinity,
                                    child: Text(
                                      "Lower jaw".toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(themeService.myColor2),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(
                                  _width / 3, 10, _width / 3, 10),
                              color: Color(themeService.myColor2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: () {
                                addRecord();
                                getRecord(_selected_day_str);
                                Toast.show("Saved Successfully!", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
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
                          Image.asset(
                            'assets/images/footer.png',
                            width: _width,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
