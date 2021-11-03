import 'package:data_buffer/services/theme_service.dart';
import 'package:data_buffer/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:data_buffer/constants/constants.dart';
import 'package:data_buffer/ui/widgets/custom_shape.dart';
import 'package:data_buffer/ui/widgets/responsive_ui.dart';
import 'package:data_buffer/ui/widgets/textformfield.dart';
import 'package:data_buffer/ui/dashboard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  UserService userService = UserService();
  ThemeService themeService = ThemeService();
  final double infoHeight = 400.0;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  List<String> userData = ["", "", "", "", "", "", "", "", "", "", ""];

  @override
  void initState() {
    changeTheme();
    super.initState();
  }

  changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // userService.gender = prefs.getString("gender");
    userData = prefs.getStringList("userData");
    userService.id = int.parse(userData[0]);
    userService.full_name = userData[1];
    userService.doctor_name = userData[2];
    userService.dentist_name = userData[3];
    userService.birthday = userData[4];
    userService.gender = userData[5];
    userService.weight = userData[6];
    userService.length = userData[7];
    userService.time = userData[8];
    userService.avatar_path = userData[9];
    userService.user_role = userData[10];
    if (userService.gender == "Male") {
      setState(() {
        themeService.myColor1 = 0xFF015098;
        themeService.myColor2 = 0xFF3196E0;
        themeService.myColor3 = 0xFF1974BD;
      });
    } else if (userService.gender == "Female") {
      setState(() {
        themeService.myColor1 = 0xFF97036D;
        themeService.myColor2 = 0xFFC654C1;
        themeService.myColor3 = 0xFFAF2C98;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width) +
        70.0;
    return Material(
      child: GestureDetector(
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
          height: _height,
          width: _width,
          padding: EdgeInsets.only(bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                clipShape(),
                welcomeTextRow(),
                signInTextRow(),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color(0xFF3A5160).withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: 400,
                            maxHeight: tempHeight > infoHeight
                                ? tempHeight
                                : infoHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            form(),
                            SizedBox(height: _height / 50),
                            button(),
                            forgetPassTextRow(),
                            signUpTextRow(),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton.icon(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    color: Color(0xFFFFDBDB),
                                    icon: Icon(
                                      FontAwesomeIcons.google,
                                      color: Color(0xFFDA483F),
                                    ),
                                    label: Text(
                                      "Google  ",
                                      style:
                                          TextStyle(color: Color(0xFFDA483F)),
                                    ),
                                    onPressed: () {},
                                  ),
                                  RaisedButton.icon(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    color: Color(0xFFE0E3FF),
                                    icon: Icon(
                                      FontAwesomeIcons.facebook,
                                      color: Color(0xFF3D5A96),
                                    ),
                                    label: Text(
                                      "Facebook",
                                      style:
                                          TextStyle(color: Color(0xFF3D5A96)),
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: _height / 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
              top: _large
                  ? _height / 15
                  : (_medium ? _height / 12.5 : _height / 10)),
          child: Image.asset(
            'assets/images/baby_tooth.gif',
            height: _height * 0.25,
            width: _width * 0.8,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Welcome",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: _large ? 40 : (_medium ? 30 : 20),
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to your account",
            style: TextStyle(
              color: Colors.white.withOpacity(0.61),
              fontWeight: FontWeight.normal,
              fontSize: _large ? 17 : (_medium ? 15 : 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
        left: _width / 12.0,
        right: _width / 12.0,
      ),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: emailController,
      icon: Icons.email,
      hint: "Email",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: passwordController,
      icon: Icons.lock,
      obscureText: true,
      hint: "Password",
    );
  }

  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0, left: _width / 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "Forgot your password?",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF313131)),
            ),
          )
        ],
      ),
    );
  }

  Widget button() {
    return Container(
      width: _width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (ctx) => DashboardScreen("admin", "")))
                    .then((value) => changeTheme());
              },
              textColor: Colors.white,
              padding: EdgeInsets.all(0.0),
              child: Container(
                  alignment: Alignment.center,
                  width: _large
                      ? _width * .8
                      : (_medium ? _width * .8 : _width * .8),
                  height: _large
                      ? _height / 15
                      : (_medium ? _height / 15 : _height / 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(themeService.myColor3),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      Text('sign in'.toUpperCase(),
                          style: TextStyle(
                              fontSize: _large ? 22 : (_medium ? 20 : 18))),
                      Spacer(),
                      Icon(
                        FontAwesomeIcons.arrowCircleRight,
                      ),
                    ],
                  )),
            ),
          ]),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "New Here?",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: _large ? 20 : (_medium ? 18 : 16),
                color: Color(0xFF313131)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(SIGN_UP);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Create Account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(themeService.myColor2),
                fontSize: _large ? 20 : (_medium ? 18 : 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
