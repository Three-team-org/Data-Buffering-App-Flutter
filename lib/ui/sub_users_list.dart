import 'package:data_buffer/database/model/form.dart';
import 'package:data_buffer/services/theme_service.dart';
import 'package:data_buffer/services/user_service.dart';
import 'package:data_buffer/ui/sub_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:data_buffer/ui/sub_recipe_month_page.dart';
import 'package:data_buffer/database/model/user_data.dart';
import 'package:data_buffer/database/database_helper.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:data_buffer/ui/dashboard.dart';
import 'package:toast/toast.dart';
import 'package:data_buffer/ui/sub_data_add_new_user.dart';

class UsersListPage extends StatefulWidget {
  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _UsersListPageState extends State<UsersListPage> {
  UserService userService = UserService();
  ThemeService themeService = ThemeService();
  List<Employee> employees = <Employee>[];
  EmployeeDataSource employeeDataSource;
  List<User_data> employee;
  double _width, _height;

  List<Map> list;
  var db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
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
                            "User List".toUpperCase(),
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
                  height: _height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: _height / 30,
                    right: _width / 20,
                    bottom: _height / 30,
                    left: _width / 20,
                  ),
                  child: FutureBuilder<List>(
                    future: db.getUserInfo_all(),
                    initialData: List(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, int position) {
                                final item = snapshot.data[position];
                                //get your item data here ...
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (ctx) => DashboardScreen(
                                      //         snapshot.data[position].row[10],
                                      //         snapshot.data[position].row[1])));
                                      setUserData(snapshot.data[position].row);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                DataPage("admin", "")),
                                      );
                                    },
                                    title: new Container(
                                      child: Row(
                                        children: <Widget>[
                                          Image.network(
                                            "https://cdn.icon-icons.com/icons2/2643/PNG/512/male_man_people_person_avatar_white_tone_icon_159363.png",
                                            width: 60,
                                            height: 60,
                                          ),
                                          Spacer(),
                                          Text(snapshot.data[position].row[1]),
                                          Spacer(),
                                          Text(snapshot.data[position].row[4]),
                                          Spacer(),
                                          IconButton(
                                            icon: new Icon(
                                                FontAwesomeIcons.trashAlt),
                                            iconSize: 25,
                                            highlightColor: Colors.pink,
                                            onPressed: () {
                                              _showerrorDialog(
                                                  snapshot
                                                      .data[position].row[0],
                                                  snapshot
                                                      .data[position].row[1]);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void setUserData(user_data) {
    userService.id = user_data[0];
    userService.full_name = user_data[1];
    userService.doctor_name = user_data[2];
    userService.dentist_name = user_data[3];
    userService.birthday = user_data[4];
    userService.gender = user_data[5];
    userService.weight = user_data[6];
    userService.length = user_data[7];
    userService.time = user_data[8];
    userService.avatar_path = user_data[9];
    userService.user_role = user_data[10];
  }

  void _showerrorDialog(int user_id, String user_name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Warning!',
          style: TextStyle(color: Colors.red),
        ),
        content: Text("Are you sure you want to delete $user_name ? "),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              db.deleteUsers(user_id);
              Toast.show("Removed Successfully!", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => DataPage("admin", "")));
            },
          ),
          Spacer(),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.no, this.name, this.birthday, this.role);

  /// Id of an employee.
  final int no;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String birthday;

  /// Salary of an employee.
  final String role;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.no),
              DataGridCell<String>(columnName: 'fullname', value: e.name),
              DataGridCell<String>(columnName: 'birthday', value: e.birthday),
              DataGridCell<String>(columnName: 'role', value: e.role),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (e) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(e.value.toString()),
        );
      },
    ).toList());
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
