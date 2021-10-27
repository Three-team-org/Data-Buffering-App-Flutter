import 'package:data_buffer/services/theme_service.dart';
import 'package:data_buffer/ui/sub_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:data_buffer/ui/sub_data.dart';
import 'package:data_buffer/ui/sub_advices.dart';
import 'package:data_buffer/ui/sub_new_page_dashboard.dart';
import 'package:data_buffer/ui/sub_plan.dart';
import 'package:data_buffer/ui/widgets/responsive_ui.dart';

class DashboardScreen extends StatefulWidget {
  String user_role = "", user_name = "";
  DashboardScreen(@required this.user_role, @required this.user_name);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ThemeService themeService = ThemeService();
  final TextStyle whiteText = TextStyle(color: Colors.white);
  final double infoHeight = 400.0;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  Widget cards(image, title, price, page_num) {
    return GestureDetector(
      onTap: () {
        switch (page_num) {
          case 1:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    DataPage(widget.user_role, widget.user_name)));
            break;
          case 2:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    PlanPage(widget.user_role, widget.user_name)));
            break;
          case 3:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    AdvicesPage(widget.user_role, widget.user_name)));
            break;
          case 4:
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => NewPageDashboardScreen()));
            break;
        }
      },
      child: Container(
        height: _height / 3,
        width: _width - 100,
        child: Image.asset(
          image,
          height: _height / 3,
          width: _width - 50,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget cards_one(image, title, price, page_num, height, width) {
    return GestureDetector(
      onTap: () {
        switch (page_num) {
          case 1:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    DataPage(widget.user_role, widget.user_name)));
            break;
          case 2:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    PlanPage(widget.user_role, widget.user_name)));
            break;
          case 3:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    AdvicesPage(widget.user_role, widget.user_name)));
            break;
          case 4:
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => NewPageDashboardScreen()));
            break;
        }
      },
      child: Container(
        height: height,
        width: width,
        // color: Colors.white,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Image.asset(
          image,
          height: _height / 5,
          width: _width - 50,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width) +
        70.0;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
        backgroundColor: Colors.white70.withOpacity(0.9),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
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
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Text("Welcome !",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.white)),
                  )),
              Container(
                margin: EdgeInsets.only(top: 80),
                decoration: BoxDecoration(
                  // color: Color(0xFFFFFFFF),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
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
                          minHeight: _height - 120, maxHeight: _height),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: _height / 50,
                          ),
                          Row(
                            children: <Widget>[
                              Spacer(),
                              Text("my dashboard".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white)),
                              Spacer(),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Spacer(),
                              Text("Please visit everywhere",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: _height / 50,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      // height: _height * 0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Spacer(),
                                              cards_one(
                                                  "assets/images/icon_data.png",
                                                  'DATA',
                                                  '30',
                                                  1,
                                                  _height * 0.4,
                                                  _width / 2 - 30),
                                              Spacer(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      // height: _height / 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Spacer(),
                                              cards_one(
                                                  "assets/images/icon_new.png",
                                                  'NEW',
                                                  '90',
                                                  4,
                                                  _height * 0.3,
                                                  _width / 2 - 30),
                                              Spacer(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      // height: _height / 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Spacer(),
                                              cards_one(
                                                  "assets/images/icon_plan.png",
                                                  'PLAN',
                                                  '37',
                                                  2,
                                                  _height * 0.3,
                                                  _width / 2 - 30),
                                              Spacer(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Container(
                                      // height: _height * 0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Spacer(),
                                              cards_one(
                                                  "assets/images/icon_advice.png",
                                                  'ADVICE',
                                                  '22',
                                                  3,
                                                  _height * 0.4,
                                                  _width / 2 - 30),
                                              Spacer(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Container(
                          //   width: _width,
                          //   height: _height / 4,
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       image: AssetImage(
                          //         'assets/images/dashboard_footer.png',
                          //       ),
                          //     ),
                          //   ),
                          // )
                          // Image.asset(
                          //   'assets/images/dashboard_footer.png',
                          //   height: _height / 4,
                          //   width: _width,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
