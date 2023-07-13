import 'package:flutter/material.dart';
import 'package:weather_app_julian/pages/city/city.dart';
import 'package:weather_app_julian/pages/get_started/get_started.dart';
import 'package:weather_app_julian/pages/home/home.dart';
import 'package:weather_app_julian/pages/search_city/search_city.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  
  "getStarted": (_) =>  const GetStartedPage(),
  "home": (_) => const HomePage(),
  "city": (_) => const CityPage(),
  "searchCity":(_) => const SearchCityPage()
};
