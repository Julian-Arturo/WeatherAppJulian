import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_julian/controller/logic_controller.dart';
import 'package:weather_app_julian/model/city_model.dart';
import 'package:weather_app_julian/utils/size_desing.dart';

class CitySearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar ciudad";
  City? selectedCity;

  @override
  TextStyle get searchFieldStyle => const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontStyle: FontStyle.italic,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
        query = "";
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final logicController =
        Provider.of<LogicController>(context, listen: false);
    Responsive size = Responsive(context);

    return FutureBuilder<List<City>>(
      future: logicController.searchCities(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Container(
              width: size.width * 0.5,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffFA4A0C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'No se encontraron resultados',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final city = snapshot.data![index];
              return ListTile(
                title: Text(city.name!),
                subtitle: Text(city.country!),
                onTap: () {
                  close(context, city);
                  Navigator.pushNamed(
                    context,
                    "home",
                    arguments:city.name,
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final logicController =
        Provider.of<LogicController>(context, listen: false);
    Responsive size = Responsive(context);

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder<List<City>>(
      future: logicController.searchCities(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Container(
              width: size.width * 0.5,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffFA4A0C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'No se encontraron resultados',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          final cities = snapshot.data!;
          final suggestedCities =
              cities.take(20).toList(); // Obtener las primeras 20 ciudades

          return ListView.builder(
            itemCount: suggestedCities.length,
            itemBuilder: (context, index) {
              final city = suggestedCities[index];
              return ListTile(
                title: Text(city.name!),
                subtitle: Text(city.country!),
                onTap: () {
                  close(context, city);
                },
              );
            },
          );
        }
      },
    );
  }
}
