import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_julian/model/city_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_julian/model/weartherdata_model.dart';

class LogicController extends ChangeNotifier {
  Logger logger = Logger();
  static const String baseUrl = "https://api.openweathermap.org";
  final apiKey = '3719358a9bad2da40d568ec4f64b9a67';
  WeatherData? currentCity;

  LogicController() {
    _getCurrentLocation();
  }
  Future<List<City>> searchCities(String query) async {
    try {
      var url = Uri.parse('$baseUrl/data/2.5/find?q=$query&appid=$apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final citiesJson = json['list'] as List<dynamic>;
        final cities = citiesJson.map((json) => City.fromJson(json)).toList();
        return cities;
      } else {
        throw Exception('Failed to search cities');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getDataCity(String cityName) async {
    try {
      var url =
          Uri.parse('$baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final weatherData = WeatherData.fromJson(json);
        currentCity = weatherData;
      } else {
        throw Exception('Failed to fetch city data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Manejar el caso de permiso denegado
      // Mostrar un diálogo de error o solicitar permiso nuevamente
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    logger.d(position.latitude);
    logger.d(position.longitude);

    double latitude = position.latitude;
    double longitude = position.longitude;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    String cityName = placemarks.isNotEmpty
        ? placemarks.first.locality ?? 'Unknown'
        : 'Unknown';

    await getDataCity(cityName);
    notifyListeners();
  }


  Future<void> getDataByLocation(double latitude, double longitude) async {
    try {
      var url = Uri.parse(
          '$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final weatherData = WeatherData.fromJson(json);
        currentCity = weatherData;
        logger.i(currentCity);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch location data');
      }
    } catch (e) {
      rethrow;
    }
  }

}
