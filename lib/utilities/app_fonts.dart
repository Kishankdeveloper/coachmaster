import 'package:flutter/material.dart';

class AppFonts {
  static TextStyle textStyleUnderLined = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
    color: Colors.blue,
    //decoration: TextDecoration.underline,
  );
  static TextStyle textStyleUnderLinedSmall = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
    color: Colors.blue,
    //decoration: TextDecoration.underline,
  );
  static TextStyle contentTextStyle = const TextStyle(fontSize: 14);
  static TextStyle formHeadingTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle appBarUserDetailTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  static TextStyle appBarTitleTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
  static TextStyle reportLabelText = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle reportContentText = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle reportHeadingText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.blue,
  );
}
