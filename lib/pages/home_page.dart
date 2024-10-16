// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_api/service/weather_service.dart';

import '../model/weather_model.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  // API KEY
  final _weatherService = WeatherService('2f75f698babc4950b47bcb4623e9c98f');
  Weather? _weather;

  // FETCH WEATHER
  _fetchWeather() async {
    //GET CURRENT CITY
    String cityName = await _weatherService.getCurrentCity();

    //GET WEATHER FOR CITY
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //WEATHER ANIMATIONS CONDITIONS

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; // default sunny

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstrom':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // INIT STATE
  @override
  void initState() {
    super.initState();

    // FETCH WEATHER ON STARTUP
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _weather?.cityName.toUpperCase() ??
                  'Loading city..'.toUpperCase(),
              style: GoogleFonts.openSans(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),

            // LOTTIE ANIMATION
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            SizedBox(
              height: 30,
            ),

            Text(
              '${_weather?.temparature.round()}°C',
              style: GoogleFonts.openSans(
                  color: Colors.grey,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
