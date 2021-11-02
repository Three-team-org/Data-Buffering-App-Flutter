import 'package:data_buffer/database/model/user_data.dart';

class UserService {
  static final UserService _instance = UserService._internal();

  // passes the instantiation to the _instance object
  factory UserService() => _instance;

  UserService._internal() {
    _id = 0;
    _full_name = "";
    _doctor_name = "";
    _dentist_name = "";
    _birthday = "";
    _gender = "";
    _weight = "";
    _length = "";
    _time = "";
    _avatar_path = "";
    _user_role = "";
  }

  int _id;
  String _full_name;
  String _doctor_name;
  String _dentist_name;
  String _birthday;
  String _gender;
  String _weight;
  String _length;
  String _time;
  String _avatar_path;
  String _user_role;

  //short getter for my variable
  int get id => _id;
  String get full_name => _full_name;
  String get doctor_name => _doctor_name;
  String get dentist_name => _dentist_name;
  String get birthday => _birthday;
  String get gender => _gender;
  String get weight => _weight;
  String get length => _length;
  String get time => _time;
  String get avatar_path => _avatar_path;
  String get user_role => _user_role;

  //short setter for my variable
  set id(int id) => _id = id;
  set full_name(String full_name) => _full_name = full_name;
  set doctor_name(String doctor_name) => _doctor_name = doctor_name;
  set dentist_name(String dentist_name) => _dentist_name = dentist_name;
  set birthday(String birthday) => _birthday = birthday;
  set gender(String gender) => _gender = gender;
  set weight(String weight) => _weight = weight;
  set length(String length) => _length = length;
  set time(String time) => _time = time;
  set avatar_path(String avatar_path) => _avatar_path = avatar_path;
  set user_role(String user_role) => _user_role = user_role;
}
