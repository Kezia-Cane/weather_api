import 'package:flutter/material.dart';
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
            Text(_weather?.cityName ?? 'Loading city..'),

            // LOTTIE ANIMATION
            Lottie.asset('assets/thunder.json'),

            Text('${_weather?.temparature.round()}°C')
          ],
        ),
      ),
    );
  }
}
