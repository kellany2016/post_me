import 'package:flutter/material.dart';

Widget buildCoverImage(Size screenSize) {
  return Container(
    height: screenSize.height / 4,
    color: Color(0xffb2dfdb),
  );
}

Widget buildProfileImage() {
  return Center(
    child: Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/ahmed.jpg'), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(color: Color(0xFF39796b), width: 3.0)),
    ),
  );
}

Widget buildName() {
  TextStyle textStyle = TextStyle(
      fontSize: 28.0, color: Colors.black, fontWeight: FontWeight.w700);
  return Text(
    'اسم المستخدم',
    style: textStyle,
  );
}

Widget buildEmail() {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      'User99@gmail.com',
      style: TextStyle(color: Colors.grey),
    ),
  );
}

Widget buildRowItems(icon, text) {
  return Column(
    children: <Widget>[
      Container(
          decoration: BoxDecoration(
              color: Color(0xffb2dfdb),
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: Color(0xffb2dfdb), width: 9.0)),
          child: Icon(
            icon,
          )),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      )
    ],
  );
}
