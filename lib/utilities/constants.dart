import 'package:flutter/material.dart';

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 38.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  color: Colors.white70,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  // filled: true,
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    height: 1.3,
    fontSize: 23,
  ),
  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.location_city,
    size: 35,
    color: Colors.white,
  ),
);
