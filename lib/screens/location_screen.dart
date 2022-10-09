import 'package:clima/screens/loading_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'city_screen.dart';

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
    Future.delayed(Duration.zero, () {
      updateUI(widget.locationWeather);
    });
  }

  void updateUI(weatherData) {
    setState(() {
      if (weatherData == null) {
        Alert(
          style: AlertStyle(
            titleStyle: TextStyle(
              fontFamily: 'Spartan MB',
              color: Colors.black,
            ),
            descStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
          context: context,
          type: AlertType.error,
          title: "ERROR!",
          desc: "UNABLE TO FETCH WEATHER DATA",
          buttons: [
            DialogButton(
              child: Text(
                "RETRY",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoadingScreen();
                    },
                  ),
                );
              },
              width: 120,
            )
          ],
        ).show();

        return;
      }
      temperature = (weatherData['main']['temp']).toInt();
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (temperature == null) {
      return Scaffold();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/waterfall.gif'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.6), BlendMode.dstATop),
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
                      onPressed: () async {
                        String typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var newWeatherData =
                              await WeatherModel().getCityWeather(typedName);
                          updateUI(newWeatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: screenHeight * 0.045,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoadingScreen();
                            },
                          ),
                        );
                      },
                      child: Icon(
                        Icons.my_location,
                        size: screenHeight * 0.045,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: screenHeight * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '$temperature°',
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                            fontSize: screenHeight * 0.11,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          weather.getWeatherIcon(condition),
                          style: TextStyle(
                            fontSize: screenHeight * 0.12,
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
                child: SizedBox(
                  height: 1,
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(right: screenHeight * 0.02),
                  child: Text(
                    '${weather.getMessage(temperature)} in $cityName!',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Spartan MB',
                      fontSize: screenHeight * 0.042,
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
