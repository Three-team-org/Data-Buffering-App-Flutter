class Hospital_data {
  int id;
  String _doctor_name;
  String _dentist_name;
  String _weight;
  String _length;
  String _advice;
  String _remarks;

  String _date_save;
  String _user_role;
  String _user_name;
  int _user_id;

  Hospital_data(
    this._doctor_name,
    this._dentist_name,
    this._weight,
    this._length,
    this._advice,
    this._remarks,
    this._date_save,
    this._user_role,
    this._user_name,
    this._user_id,
  );

  Hospital_data.map(dynamic obj) {
    this._doctor_name = obj["doctor_name"];
    this._dentist_name = obj["dentist_name"];
    this._weight = obj["weight"];
    this._length = obj["length"];
    this._advice = obj["advice"];
    this._remarks = obj["remarks"];

    this._date_save = obj["date_save"];
    this._user_role = obj["user_role"];
    this._user_name = obj["user_name"];
    this._user_id = obj["user_id"];
  }

  String get doctor_name => _doctor_name;
  String get dentist_name => _dentist_name;
  String get weight => _weight;
  String get length => _length;
  String get advice => _advice;
  String get remarks => _remarks;

  String get date_save => _date_save;
  String get user_role => _user_role;
  String get user_name => _user_name;
  int get user_id => _user_id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["doctor_name"] = _doctor_name;
    map["dentist_name"] = _dentist_name;
    map["weight"] = _weight;
    map["length"] = _length;
    map["advice"] = _advice;
    map["remarks"] = _remarks;

    map["date_save"] = _date_save;
    map["user_role"] = _user_role;
    map["user_name"] = _user_name;
    map["user_id"] = _user_id;

    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }
}
