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
class NewUserDataPage extends StatefulWidget{
  @override
  _NewUserDataPageState createState() => _NewUserDataPageState();

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class _NewUserDataPageState extends State<NewUserDataPage>{
  User_data user_data;

  bool avatar_exists = false;
  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate;
  Item selectedGender ;
  Item selected_option;
  File _image;
  List<Item> Gender = <Item>[
    const Item('Male',Icon(FontAwesomeIcons.male,color:  const Color(0xFF167F67),)),
    const Item('Female',Icon(FontAwesomeIcons.female,color:  Colors.blue,)),
  ];
  List<Item> choices = <Item>[
    const Item('Add new User',Icon(FontAwesomeIcons.plus,color:  const Color(0xFF167F67),)),
    const Item('User List',Icon(FontAwesomeIcons.list,color:  const Color(0xFF167F67),)),
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
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;
  String avatar_path;
  Future addRecord(BuildContext context) async {
    var db = new DatabaseHelper();
    print(_doctor_controller.text);
    var user_data = new User_data(_full_name_controller.text,_doctor_controller.text,_dentist_controller.text, _dateController.text,selectedGender.name,
      _weight_controller.text, _length_controller.text, _time_controller.text, avatar_path,"user");
    await db.saveUserData(user_data);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => UsersListPage()));
  }

  saveImages() async{
    final Directory directory = await getApplicationDocumentsDirectory();
    final File Image_face = await _image.copy('${directory.path}/avatar.png');

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
        }
    );
  }
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;

    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text("NEW USER DATA",style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Colors.red,
        elevation: 0,
        automaticallyImplyLeading: false,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 55,
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
                        ) : CircleAvatar(
                          minRadius: 60,
                          backgroundColor: Colors.deepOrange.shade300,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://cdn.icon-icons.com/icons2/2643/PNG/512/male_man_people_person_avatar_white_tone_icon_159363.png"),
                            minRadius: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "DOCTOR NAME",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: CustomTextField(
              textEditingController: _doctor_controller,
              keyboardType: TextInputType.text,
              icon: Icons.receipt,
              hint: "Doctor Name",
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "DENTIST NAME",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: CustomTextField(
              textEditingController: _dentist_controller,
              keyboardType: TextInputType.text,
              icon: Icons.receipt,
              hint: "Dentist Name",
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "FULL NAME",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: CustomTextField(
              textEditingController: _full_name_controller,
              keyboardType: TextInputType.text,
              icon: Icons.receipt,
              hint: "Your Full Name",
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "DATE OF BIRTH",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: Container(
              width: 150,
              padding: EdgeInsets.all(8.0),
              child:
              Material(
                borderRadius: BorderRadius.circular(30.0),
                elevation: 12,
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
                    prefixIcon: Icon(Icons.date_range, color: Colors.orange[200], size: 20),
                    hintText: "Date...",
                    border: new OutlineInputBorder(

                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),

            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "GENDER",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle:
            Material(

                borderRadius: BorderRadius.circular(30.0),
                elevation: 12,
                child:
                Row(
                  children: <Widget>[
                    Spacer(),
                    DropdownButton<Item>(

                      hint:  Text("              Select Gender"),
                      value: selectedGender,

                      onChanged: (Item Value) {
                        setState(() {
                          // print(Value.name);
                          selectedGender = Value;
                        });
                      },
                      items: Gender.map((Item user) {
                        return  DropdownMenuItem<Item>(
                          value: user,
                          child: Row(
                            children: <Widget>[
                              user.icon,
                              SizedBox(width: 10,),
                              Text(
                                user.name,
                                style:  TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    Spacer(),
                    Spacer(),
                    Spacer(),
                  ],
                )

            ),

          ),
          Divider(),
          ListTile(
            title: Text(
              "WEIGHT",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: CustomTextField(
              textEditingController: _weight_controller,
              keyboardType: TextInputType.text,
              icon: Icons.receipt,
              hint: "Your Weight",
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "LENGTH",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: CustomTextField(
              textEditingController: _length_controller,
              keyboardType: TextInputType.text,
              icon: Icons.receipt,
              hint: "Your Length",
            ),
          ),
          ListTile(
            title: Text(
              "TIME",
              style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
            ),
            subtitle: CustomTextField(
              textEditingController: _time_controller,
              keyboardType: TextInputType.text,
              icon: Icons.receipt,
              hint: "Time",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 8.0),
            child: RaisedButton(
              padding: const EdgeInsets.all(16.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Colors.yellow.shade700,
              child: Text(
                "Confirm",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {
                addRecord(context);
                saveImages();
                Toast.show("Saved Successfully!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              },
            ),
          ),
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

  @override
  void initState(){
    super.initState();
    initAvatarPath();
  }

  void initAvatarPath() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    setState(() {
      avatar_path = join(documentsDirectory.path, "avatar.png");
    });
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
