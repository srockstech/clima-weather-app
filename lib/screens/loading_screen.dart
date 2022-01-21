import 'package:flutter/material.dart';
import 'package:clima/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'e2490eb92936c771bfa507d54ebaa14b';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.getLatitude();
    longitude = location.getLongitude();
    getData();
  }

  void getData() async {
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      double temperature = decodedData['main']['temp'];
      String cityName = decodedData['name'];
      int condition = decodedData['weather'][0]['id'];

      print(temperature);
      print(cityName);
      print(condition);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
