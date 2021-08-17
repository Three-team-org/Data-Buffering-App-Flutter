
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
class HospitalPage extends StatefulWidget{
  String user_role = "", user_name = "";
  HospitalPage(@required this.user_role, @required this.user_name);
  @override
  _HospitalPageState createState() => _HospitalPageState();

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _HospitalPageState extends State<HospitalPage>{

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
  List<String> _checked_teeth_upper = [];
  List<String> _checked_teeth_lower = [];
  void changeColor(Color color) => setState(() => currentColor = color);

  Future addRecord() async {
    var db = new DatabaseHelper();
    String _checked_teeth_upper_str = _checked_teeth_upper.join(',');
    String _checked_teeth_lower_str = _checked_teeth_lower.join(',');

    var Form = new Hospital_data(_doctor_controller.text, _dentist_controller.text,_weight_controller.text,
      _length_controller.text, _advice_controller.text, _remarks_controller.text,_checked_teeth_upper_str ,
      _checked_teeth_lower_str,_selected_day_str, widget.user_role, widget.user_name
    );
    await db.saveHospitalData(Form);


  }

  getRecord(String date) async {
    var db = new DatabaseHelper();
    var maps;
    if(widget.user_role == "admin"){
      maps = await db.getHospitalData_admin(date, widget.user_role);
    }
    else{
      maps = await db.getHospitalData(date, widget.user_role, widget.user_name);
    }


    if(maps.length !=0) {

      String weight_str = maps[maps.length-1]['weight'];
      String length_str = maps[maps.length-1]['length'];
      String advice_str = maps[maps.length-1]['advice'];
      String remarks_str = maps[maps.length-1]['remarks'];
      String upper_selected_str = maps[maps.length-1]['upper_selected'];
      String lower_selected_str = maps[maps.length-1]['lower_selected'];

      setState(() {
        _weight_controller = TextEditingController(text: weight_str);
        _length_controller = TextEditingController(text: length_str);
        _advice_controller = TextEditingController(text: advice_str);
        _remarks_controller = TextEditingController(text: remarks_str);
        _checked_teeth_upper = upper_selected_str.split(',');
        _checked_teeth_lower = lower_selected_str.split(',');

      });
    }
    else{

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
      body:
        GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
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
                          getRecord(_selected_day_str);
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
                            child: Text("Weight ".toUpperCase())
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.text,
                          icon: Icons.receipt,
                          hint: "Your Weight",
                          textEditingController: _weight_controller,
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
                          textEditingController: _length_controller,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => AdvicesPage(widget.user_role, widget.user_name)));
                          },
                          child: Container(
                              color: Colors.grey.shade200,
                              padding: EdgeInsets.all(8.0),
                              width: double.infinity,
                              child: Text("Advice".toUpperCase())
                          ),
                        ),

                        Container(
                          child:
                          Material(
                            borderRadius: BorderRadius.circular(30.0),
                            elevation: large? 12 : (medium? 10 : 8),
                            child: TextFormField(
                              controller: _advice_controller,
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
                              controller: _remarks_controller,
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
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            color: Colors.grey.shade200,
                            padding: EdgeInsets.all(8.0),
                            width: double.infinity,
                            child: Text("Upper jaw".toUpperCase(), textAlign: TextAlign.center,)
                        ),
                        Container(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              CheckboxGroup(
                                activeColor: Colors.greenAccent,
                                orientation: GroupedButtonsOrientation.HORIZONTAL,
                                margin: const EdgeInsets.only(left: 8.0),
                                padding: const EdgeInsets.all(2),
                                onSelected: (List selected) => setState((){
                                  _checked_teeth_upper = selected;
                                }),

                                labels: <String>[
                                  "1", "2","3", "4","5", "6","7", "8","9", "10",
                                ],
                                checked: _checked_teeth_upper,
                                itemBuilder: (Checkbox cb, Text txt, int i){
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

                                activeColor: Colors.greenAccent,
                                orientation: GroupedButtonsOrientation.HORIZONTAL,
                                margin: const EdgeInsets.only(left: 8.0),
                                padding: const EdgeInsets.all(2),
                                onSelected: (List selected) => setState((){
                                  _checked_teeth_lower = selected;
                                }),

                                labels: <String>[
                                  "1", "2","3", "4","5", "6","7", "8","9", "10",
                                ],
                                checked: _checked_teeth_lower,
                                itemBuilder: (Checkbox cb, Text txt, int i){
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
                            child: Text("Lower jaw".toUpperCase(), textAlign: TextAlign.center,)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.red,
                      onPressed: (){
                        addRecord();
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