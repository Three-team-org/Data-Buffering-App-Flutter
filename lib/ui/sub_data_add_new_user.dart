import 'package:data_buffer/services/theme_service.dart';
import 'package:data_buffer/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:data_buffer/ui/widgets/textformfield.dart';
import 'package:data_buffer/database/model/user_data.dart';
import 'package:data_buffer/database/database_helper.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:data_buffer/ui/sub_users_list.dart';
import 'package:data_buffer/ui/widgets/customappbar.dart';
import 'package:data_buffer/ui/widgets/responsive_ui.dart';
import 'package:data_buffer/ui/dashboard.dart';

class NewUserDataPage extends StatefulWidget {
  @override
  _NewUserDataPageState createState() => _NewUserDataPageState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _NewUserDataPageState extends State<NewUserDataPage> {
  UserService userService = UserService();
  ThemeService themeService = ThemeService();
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  User_data user_data;

  bool avatar_exists = false;
  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate;
  Item selectedGender;
  Item selected_option;
  File _image;
  List<Item> Gender = <Item>[
    const Item(
        'Male',
        Icon(
          FontAwesomeIcons.male,
          color: Colors.blueAccent,
        )),
    const Item(
        'Female',
        Icon(
          FontAwesomeIcons.female,
          color: Colors.pinkAccent,
        )),
  ];
  List<Item> choices = <Item>[
    const Item(
        'Add new User',
        Icon(
          FontAwesomeIcons.plus,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'User List',
        Icon(
          FontAwesomeIcons.list,
          color: const Color(0xFF167F67),
        )),
  ];

  TextEditingController textEditingController;
  TextEditingController _full_name_controller = TextEditingController();
  TextEditingController _weight_controller = TextEditingController();
  TextEditingController _length_controller = TextEditingController();
  TextEditingController _time_controller = TextEditingController();
  TextEditingController _doctor_controller = TextEditingController();
  TextEditingController _dentist_controller = TextEditingController();

  TextInputType keyboardType;
  bool obscureText;
  IconData icon;
  bool large;
  bool medium;
  String avatar_path;
  Future addRecord(BuildContext context) async {
    var db = new DatabaseHelper();
    print(_time_controller.text);
    if (selectedGender.name == "Male") {
      setState(() {
        themeService.myColor1 = 0xFF015098;
        themeService.myColor2 = 0xFF3196E0;
        themeService.myColor3 = 0xFF1974BD;
      });
    } else {
      setState(() {
        themeService.myColor1 = 0xFF97036D;
        themeService.myColor2 = 0xFFC654C1;
        themeService.myColor3 = 0xFFAF2C98;
      });
    }

    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    avatar_path =
        join(documentsDirectory.path, "${_full_name_controller.text}.png");
    var user_data = new User_data(
        _full_name_controller.text,
        _doctor_controller.text,
        _dentist_controller.text,
        _dateController.text,
        selectedGender.name,
        _weight_controller.text,
        _length_controller.text,
        _time_controller.text,
        avatar_path,
        "user");
    await db.saveUserData(user_data);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => UsersListPage()))
        .then((value) => Navigator.pop(context));
  }

  saveImages(full_name) async {
    print(full_name);
    final Directory directory = await getApplicationDocumentsDirectory();
    final File Image_face =
        await _image.copy('${directory.path}/${full_name}.png');
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      // appBar: AppBar(
      //   title: Text("NEW USER DATA",style: TextStyle(color: Colors.white, fontSize: 25),),
      //   backgroundColor: Colors.red,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      // ),
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
              ],
            ),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                height: _height / 2.6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(themeService.myColor1),
                      Color(themeService.myColor2),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Opacity(
                          opacity: 1,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(
                          height: _height / 10,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Add New User",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: _width / 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                      width: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      // fit: BoxFit.fitHeight,
                                    ),
                                  )
                                : CircleAvatar(
                                    minRadius: 30,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://getstisla.com/dist/img/avatar/avatar-5.png"),
                                      minRadius: 25,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 30),
                decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "FULL NAME",
                        style: TextStyle(
                            color: Color(themeService.myColor2),
                            fontSize: 12.0),
                      ),
                      subtitle: CustomTextField(
                        textEditingController: _full_name_controller,
                        keyboardType: TextInputType.text,
                        icon: Icons.person,
                        hint: "Your Full Name",
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "DATE OF BIRTH",
                        style: TextStyle(
                            color: Color(themeService.myColor2),
                            fontSize: 12.0),
                      ),
                      subtitle: Container(
                        child: TextFormField(
                          controller: _dateController,
                          keyboardType: TextInputType.multiline,
                          cursorColor: Colors.orange[200],
                          maxLines: 1,
                          focusNode: AlwaysDisabledFocusNode(),
                          onTap: () {
                            _selectDate(context);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range,
                                color: Colors.orange[200], size: 20),
                            hintText: "Date",
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "GENDER",
                        style: TextStyle(
                            color: Color(themeService.myColor2),
                            fontSize: 12.0),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          DropdownButton<Item>(
                            hint: Text("Select Gender"),
                            value: selectedGender,
                            onChanged: (Item Value) {
                              setState(() {
                                selectedGender = Value;
                              });
                            },
                            items: Gender.map((Item user) {
                              return DropdownMenuItem<Item>(
                                value: user,
                                child: Row(
                                  children: <Widget>[
                                    user.icon,
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      user.name,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "WEIGHT",
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
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "LENGTH",
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
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text(
                        "TIME",
                        style: TextStyle(
                            color: Color(themeService.myColor2),
                            fontSize: 12.0),
                      ),
                      subtitle: Container(
                        child: TextFormField(
                          controller: _time_controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.schedule,
                              color: Colors.orange[200],
                            ),
                            hintText: "Time",
                          ),
                          focusNode: AlwaysDisabledFocusNode(),
                          onTap: () async {
                            TimeOfDay pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                              builder: (BuildContext context, Widget child) {
                                return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme:
                                          ColorScheme.highContrastLight(
                                        primary: Color(themeService.myColor2),
                                      ),
                                    ),
                                    child: child);
                              },
                            );

                            if (pickedTime != null) {
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              //converting to DateTime so that we can further format on different pattern.

                              String formattedTime =
                                  DateFormat('HH:mm').format(parsedTime);
                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                              setState(() {
                                _time_controller.text =
                                    formattedTime; //set the value of text field.
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text(
                        "DOCTOR NAME",
                        style: TextStyle(
                            color: Color(themeService.myColor2),
                            fontSize: 12.0),
                      ),
                      subtitle: CustomTextField(
                        textEditingController: _doctor_controller,
                        keyboardType: TextInputType.text,
                        icon: Icons.person,
                        hint: "Doctor Name",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "DENTIST NAME",
                        style: TextStyle(
                            color: Color(themeService.myColor2),
                            fontSize: 12.0),
                      ),
                      subtitle: CustomTextField(
                        textEditingController: _dentist_controller,
                        keyboardType: TextInputType.text,
                        icon: Icons.person,
                        hint: "Dentist Name",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8.0),
                      child: RaisedButton(
                        padding:
                            EdgeInsets.fromLTRB(_width / 3, 10, _width / 3, 10),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color(themeService.myColor3),
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          addRecord(context);
                          saveImages(_full_name_controller.text);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/footer.png',
                width: _width,
              ),
            ],
          ),
        ),
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
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.highContrastLight(
                primary: Color(themeService.myColor2),
              ),
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

  @override
  void initState() {
    super.initState();
    initAvatarPath();
  }

  void initAvatarPath() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    setState(() {
      avatar_path =
          join(documentsDirectory.path, "${userService.full_name}.png");
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
