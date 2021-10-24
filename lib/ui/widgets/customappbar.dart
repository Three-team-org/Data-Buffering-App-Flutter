import 'package:data_buffer/services/theme_service.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  ThemeService themeService = ThemeService();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        height: height / 15,
        width: width / 2,
        padding: EdgeInsets.only(left: 15, top: 15),
        decoration: BoxDecoration(
          //border: Border.all(color: Colors.transparent, width: 0.1),
          gradient: LinearGradient(colors: [
            Color(themeService.myColor1),
            Color(themeService.myColor3),
          ]),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              color: Colors.white,
              onPressed: () {
                print("pop");
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
