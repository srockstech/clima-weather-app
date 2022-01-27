import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x00000000),
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/waterfall.gif'),
            opacity: 0.5,
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 35),
                child: TextField(
                  onChanged: (value) {
                    cityName = value;
                  },
                  cursorColor: Colors.white,
                  cursorHeight: 21,
                  style: TextStyle(
                    height: 1,
                    fontSize: 23,
                  ),
                  decoration: kTextFieldInputDecoration,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Search',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
