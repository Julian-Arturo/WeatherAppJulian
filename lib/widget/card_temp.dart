// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weather_app_julian/model/city_model.dart';
import 'package:weather_app_julian/model/weartherdata_model.dart';
import 'package:weather_app_julian/utils/size_desing.dart';

class CardTemp extends StatelessWidget {
  CardTemp({
    Key? key,
    required this.city,
  }) : super(key: key);
  WeatherData city;

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive(context);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 70),
          width: size.width,
          height: size.height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF67E1D2),
                Color(0xFF54A8FF),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: -size.height * 0.01,
          child: SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset("assets/images/sol.png", scale: 0.8),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFFFFF),
                        Color.fromARGB(113, 255, 255, 255),
                      ],
                    ).createShader(bounds);
                  },
                  child: Text(
                    "${city.main.temp}",
                    style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.18,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   " ${city.name}",
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Image.asset(
                "assets/images/Wind.png",
                scale: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
