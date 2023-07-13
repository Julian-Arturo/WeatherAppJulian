import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_julian/controller/logic_controller.dart';
import 'package:weather_app_julian/routes/routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  [
        ChangeNotifierProvider(
          create: (_) => LogicController(),
        ),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App Julian',
        initialRoute: 'getStarted',
        routes: appRoutes,
      ),
    );
  }
}
