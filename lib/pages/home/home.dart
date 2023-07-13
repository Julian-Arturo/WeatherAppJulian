// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_julian/controller/logic_controller.dart';
import 'package:weather_app_julian/model/city_model.dart';
import 'package:weather_app_julian/utils/size_desing.dart';
import 'package:weather_app_julian/widget/card_temp.dart';
import 'package:weather_app_julian/widget/search.dart';
import 'package:geocoding/geocoding.dart';

import '../../model/weartherdata_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Logger logger = Logger();
  @override


 

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive(context);
    final responsecity = Provider.of<LogicController>(context);
    final city = responsecity.currentCity;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0x5D80E3EC),
        title: Center(
          child: Text(
            "Home",
            style: TextStyle(color: Colors.black, fontSize: size.height * 0.02),
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const Search(),
            city == null
                ? const Center(child: CircularProgressIndicator())
                : CardTemp(city: city),
          ],
        ),
      ),
    );
  }
}
