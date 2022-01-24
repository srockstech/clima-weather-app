import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/services/weather.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  int condition;
  String cityName;
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(weatherData) {
    setState(() {
      if (weather == null) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "ERROR",
          desc: "Unable to fetch location!",
          buttons: [
            DialogButton(
              child: Text(
                "Retry",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      } else {
        temperature = (weatherData['main']['temp']).toInt();
        condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build called');
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.location_city,
                        size: width * 0.1,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var newWeatherData = await weather.getLocationWeather();
                        updateUI(newWeatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: width * 0.1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '$temperature°',
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                            fontSize: width * 0.29,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          weather.getWeatherIcon(condition),
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                            fontSize: width * 0.22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    '${weather.getMessage(temperature)} in $cityName !',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Spartan MB',
                      fontSize: width * 0.12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
