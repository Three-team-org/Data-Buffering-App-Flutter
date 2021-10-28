import 'package:data_buffer/services/theme_service.dart';
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
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:data_buffer/database/model/hospital_data.dart';
import 'package:data_buffer/database/database_helper.dart';
import 'package:data_buffer/ui/sub_advices.dart';
import 'package:data_buffer/ui/widgets/customappbar.dart';

class HospitalPage extends StatefulWidget {
  String user_role = "", user_name = "";
  HospitalPage(@required this.user_role, @required this.user_name);
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _HospitalPageState extends State<HospitalPage> {
  ThemeService themeService = ThemeService();
  Hospital_data hospital_data;

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
  TextEditingController _dentist_controller = TextEditingController();
  TextEditingController _weight_controller = TextEditingController();
  TextEditingController _length_controller = TextEditingController();
  TextEditingController _advice_controller = TextEditingController();
  TextEditingController _remarks_controller = TextEditingController();

  double _width, _height;
  double _pixelRatio;
  bool large;
  bool medium;
  List<String> color_list =
      List.filled(20, "${Colors.white.value.toRadixString(16)}");
  Widget bigCircle = new Container(
    width: 300.0,
    height: 300.0,
    decoration: new BoxDecoration(
      color: Colors.orange,
      shape: BoxShape.circle,
    ),
  );

  void changeColor(Color color) => setState(() => currentColor = color);

  Future addRecord() async {
    var db = new DatabaseHelper();

    var Form = new Hospital_data(
        _doctor_controller.text,
        _dentist_controller.text,
        _weight_controller.text,
        _length_controller.text,
        _advice_controller.text,
        _remarks_controller.text,
        _selected_day_str,
        widget.user_role,
        widget.user_name);
    await db.saveHospitalData(Form);
  }

  getRecord(String date) async {
    var db = new DatabaseHelper();
    var maps;
    if (widget.user_role == "admin") {
      maps = await db.getHospitalData_admin(date, widget.user_role);
    } else {
      maps = await db.getHospitalData(date, widget.user_role, widget.user_name);
    }

    if (maps.length != 0) {
      String weight_str = maps[maps.length - 1]['weight'];
      String length_str = maps[maps.length - 1]['length'];
      String advice_str = maps[maps.length - 1]['advice'];
      String remarks_str = maps[maps.length - 1]['remarks'];

      setState(() {
        _weight_controller = TextEditingController(text: weight_str);
        _length_controller = TextEditingController(text: length_str);
        _advice_controller = TextEditingController(text: advice_str);
        _remarks_controller = TextEditingController(text: remarks_str);
      });
    } else {
      _weight_controller = TextEditingController(text: "");
      _length_controller = TextEditingController(text: "");
      _advice_controller = TextEditingController(text: "");
      _remarks_controller = TextEditingController(text: "");
      // _checked_teeth_upper = [];
      // _checked_teeth_lower = [];
    }
  }

  @override
  void initState() {
    timeinput.text = ""; //set the initial value of text field
    super.initState();
    getRecord(_selected_day_str);
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    Color _colors = new Color(20);
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
                  height: _height / 7,
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
                            "PEDIATRICIAN".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _width / 15,
                            ),
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
                    right: _width / 40,
                    bottom: _height / 30,
                    left: _width / 40,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Image.asset(
                                        'assets/images/doctor_calendar.png',
                                        fit: BoxFit.fill,
                                        height: _height / 2,
                                        width: _width * 0.9,
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: _height * 0.01),
                                        width: _width * 0.89,
                                        height: _height * 0.45,
                                        child: TableCalendar(
                                          rowHeight: _height * 0.05,
                                          firstDay: DateTime.utc(2010, 10, 16),
                                          lastDay: DateTime.utc(2030, 3, 14),
                                          focusedDay: _focusedDay,
                                          selectedDayPredicate: (day) {
                                            return isSameDay(_selectedDay, day);
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
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    "Weight".toUpperCase(),
                                    style: TextStyle(
                                        color: Color(themeService.myColor2),
                                        fontSize: 12.0),
                                  ),
                                  subtitle: CustomTextField(
                                    textEditingController: _weight_controller,
                                    keyboardType: TextInputType.text,
                                    icon: Icons.monitor_weight,
                                    hint: "Your Weight",
                                  ),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                    "Length".toUpperCase(),
                                    style: TextStyle(
                                        color: Color(themeService.myColor2),
                                        fontSize: 12.0),
                                  ),
                                  subtitle: CustomTextField(
                                    textEditingController: _length_controller,
                                    keyboardType: TextInputType.text,
                                    icon: Icons.straighten,
                                    hint: "Your Length",
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15.0),
                                  width: double.infinity,
                                  child: Text(
                                    "Advice".toUpperCase(),
                                    style: TextStyle(
                                      color: Color(themeService.myColor2),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(30.0),
                                    elevation: large ? 12 : (medium ? 10 : 8),
                                    child: TextFormField(
                                      controller: _advice_controller,
                                      keyboardType: TextInputType.multiline,
                                      cursorColor: Colors.orange[200],
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.input,
                                            color: Colors.orange[200],
                                            size: 20),
                                        hintText: "Advice...",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15.0),
                                  width: double.infinity,
                                  child: Text(
                                    "Remarks".toUpperCase(),
                                    style: TextStyle(
                                      color: Color(themeService.myColor2),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(30.0),
                                    elevation: large ? 12 : (medium ? 10 : 8),
                                    child: TextFormField(
                                      controller: _remarks_controller,
                                      keyboardType: TextInputType.multiline,
                                      cursorColor: Colors.orange[200],
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.input,
                                            color: Colors.orange[200],
                                            size: 20),
                                        hintText: "Remarks...",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: _width,
                            padding: EdgeInsets.fromLTRB(
                                _width / 18, 10, _width / 18, 10),
                            child: RaisedButton(
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
                          Image.asset(
                            'assets/images/footer.png',
                            width: _width,
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          )),
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
