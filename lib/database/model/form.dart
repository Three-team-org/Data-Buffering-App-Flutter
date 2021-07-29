class Form_draft {

  int id;
  String _grocery_name;
  String _water_type;
  String _vit_type;
  String _color;
  String _reaction;
  String _hygiene;
  String _date;
  String _spoon_select;
  Form_draft(this._grocery_name,this._water_type,this._vit_type,this._color,this._reaction,
      this._hygiene,this._date, this._spoon_select);

  Form_draft.map(dynamic obj) {
    this._grocery_name = obj["grocery_name"];
    this._water_type = obj["water_type"];
    this._vit_type = obj["vit_type"];
    this._color = obj["color"];
    this._reaction = obj["reaction"];
    this._hygiene = obj["hygiene"];
    this._date = obj["date"];
    this._spoon_select = obj["spoon_select"];
  }

  String get grocery_name => _grocery_name;
  String get water_type => _water_type;
  String get vit_type => _vit_type;
  String get color => _color;
  String get reaction => _reaction;
  String get hygiene => _hygiene;
  String get date => _date;
  String get spoon_select =>_spoon_select;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["grocery_name"] = _grocery_name;
    map["water_type"] = _water_type;
    map["vit_type"] = _vit_type;
    map["color"] = _color;
    map["reaction"] = _reaction;
    map["hygiene"] = _hygiene;
    map["date"] = _date;
    map["spoon_select"] = _spoon_select;
    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }
}
