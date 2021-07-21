class Hospital_data {

  int id;
  String _doctor_name;
  String _dentist_name;
  String _weight;
  String _length;
  String _advice;
  String _remarks;
  String _upper_selected;
  String _lower_selected;
  String _date_save;

  Hospital_data(this._doctor_name,this._dentist_name,this._weight,this._length,this._advice,
      this._remarks, this._upper_selected, this._lower_selected, this._date_save);

  Hospital_data.map(dynamic obj) {
    this._doctor_name = obj["doctor_name"];
    this._dentist_name = obj["dentist_name"];
    this._weight = obj["weight"];
    this._length = obj["length"];
    this._advice = obj["advice"];
    this._remarks = obj["remarks"];
    this._upper_selected = obj["upper_selected"];
    this._lower_selected = obj["lower_selected"];
    this._date_save = obj["date_save"];
  }

  String get doctor_name => _doctor_name;
  String get dentist_name => _dentist_name;
  String get weight => _weight;
  String get length => _length;
  String get advice => _advice;
  String get remarks => _remarks;
  String get upper_selected => _upper_selected;
  String get lower_selected => _lower_selected;
  String get date_save => _date_save;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["doctor_name"] = _doctor_name;
    map["dentist_name"] = _dentist_name;
    map["weight"] = _weight;
    map["length"] = _length;
    map["advice"] = _advice;
    map["remarks"] = _remarks;
    map["upper_selected"] = _upper_selected;
    map["lower_selected"] = _lower_selected;
    map["date_save"] = _date_save;


    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }
}
