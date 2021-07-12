import 'package:flutter/material.dart';
import 'package:data_buffer/constants/constants.dart';
import 'package:data_buffer/ui/widgets/custom_shape.dart';
import 'package:data_buffer/ui/widgets/responsive_ui.dart';
import 'package:data_buffer/ui/widgets/textformfield.dart';
import 'package:data_buffer/ui/dashboard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();



  @override
  Widget build(BuildContext context) {
     _height = MediaQuery.of(context).size.height;
     _width = MediaQuery.of(context).size.width;
     _pixelRatio = MediaQuery.of(context).devicePixelRatio;
     _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
     _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              signInTextRow(),
              form(),
              forgetPassTextRow(),
              SizedBox(height: _height / 20),
              button(),
              signUpTextRow(),
              Row(children: <Widget>[
                googleLoginRow(),
                facebookLoginRow(),
              ],)

            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height:_large? _height/4 : (_medium? _height/3.75 : _height/3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red[400], Colors.redAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large? _height/4.5 : (_medium? _height/4.25 : _height/4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red[400], Colors.redAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: _large? _height/15 : (_medium? _height/12.5 : _height/10)),
          child: Text("Your Logo Here!", style: TextStyle(fontSize: 25, color: Colors.blueAccent),)
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
              fontSize: _large? 40 : (_medium? 30 : 20),
            ),
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
              fontWeight: FontWeight.normal,
              fontSize: _large? 15 : (_medium? 12.5 : 10),
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
          top: _height / 30.0),
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
      hint: "Email ID",
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
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Forgot your password?",
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: _large? 14: (_medium? 12: 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "Recover",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.orange[200]),
            ),
          )
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
          print("Routing to your account");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => DashboardScreen()));
          Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text('Login Successful')));

      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large? _width/2 : (_medium? _width/2: _width/2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('LOGIN',style: TextStyle(fontSize: _large? 14: (_medium? 12: 10))),
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "New Here?",
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: _large? 14: (_medium? 12: 10)),
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
                  fontWeight: FontWeight.bold, color: Colors.orange[200], fontSize: _large? 19: (_medium? 17: 15)),
            ),
          )
        ],
      ),
    );
  }
  Widget googleLoginRow(){
    return InkWell(
            child: Container(
                width: _large? _width/2 : (_medium? _width/2: _width/2),
                height: _large? _height/18 : (_medium? _height/18: _height/18),
                margin: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        ),
                        RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0)),
                          color: Colors.red,
                          icon: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Google  ",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {},
                        ),

                      ],
                    )
                )
            ),
            onTap: ()
            {
            },
    );
  }
  Widget facebookLoginRow(){
    return InkWell(
      child: Container(
          width: _large? _width/2 : (_medium? _width/2: _width/2),
          height: _large? _height/18 : (_medium? _height/18: _height/18),
          margin: EdgeInsets.only(top: 25),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0)),
                    color: Colors.indigo,
                    icon: Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Facebook",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ],
              )
          )
      ),
      onTap: ()
      {
      },
    );
  }
}
