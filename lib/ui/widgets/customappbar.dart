import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        height: height / 14,
        width: width / 2,
        padding: EdgeInsets.only(left: 15, top: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ Color(0xFFE14C37), Color(0xFFEA7330),]
          ),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back_ios,),
                color: Colors.white,
                onPressed: (){
                  print("pop");
                  Navigator.of(context).pop();
            })
          ],
        ),
      ),
    );
  }
}
