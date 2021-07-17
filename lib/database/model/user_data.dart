class User_data {

  int id;
  String _full_name;
  String _birthday;
  String _gender;
  String _weight;
  String _length;
  String _time;
  String _avatar_path;


  User_data(this._full_name,this._birthday,this._gender,this._weight,this._length,
      this._time, this._avatar_path);

  User_data.map(dynamic obj) {
    this._full_name = obj["full_name"];
    this._birthday = obj["birthday"];
    this._gender = obj["gender"];
    this._weight = obj["weight"];
    this._length = obj["length"];
    this._time = obj["time"];
    this._avatar_path = obj["avatar_path"];
  }

  String get full_name => _full_name;
  String get birthday => _birthday;
  String get gender => _gender;
  String get weight => _weight;
  String get length => _length;
  String get time => _time;
  String get avatar_path => _avatar_path;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["full_name"] = _full_name;
    map["birthday"] = _birthday;
    map["gender"] = _gender;
    map["weight"] = _weight;
    map["length"] = _length;
    map["time"] = _time;
    map["avatar_path"] = _avatar_path;


    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }
}