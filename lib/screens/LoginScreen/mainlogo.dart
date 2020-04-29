import 'package:flutter/material.dart';

Widget mainLogo() {
  return Expanded(
    child: Container(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.fill,
        )),
  );
}
