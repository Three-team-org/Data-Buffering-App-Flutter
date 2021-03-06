class ThemeService {
  static final ThemeService _instance = ThemeService._internal();

  // passes the instantiation to the _instance object
  factory ThemeService() => _instance;

  ThemeService._internal() {
    _myColor1 = 0xFFE14C37;
    _myColor2 = 0xFFF5A327;
    _myColor3 = 0xFFEA7330;
  }

  int _myColor1;
  int _myColor2;
  int _myColor3;

  //short getter for my variable
  int get myColor1 => _myColor1;
  int get myColor2 => _myColor2;
  int get myColor3 => _myColor3;

  //short setter for my variable
  set myColor1(int color) => _myColor1 = color;
  set myColor2(int color) => _myColor2 = color;
  set myColor3(int color) => _myColor3 = color;
}
