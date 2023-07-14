import '../export.dart';

class CitySearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar ciudad";
  City? selectedCity;
  List<String> selectedCities = [];

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

  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final logicController =
            Provider.of<LogicController>(context, listen: false);
        selectedCities.forEach((city) {
          logicController.addSelectedCity(city);
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(selectedCities: selectedCities)),
          (route) => false,
        );
      },
      child: const Icon(Icons.check),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final logicController =
        Provider.of<LogicController>(context, listen: false);
    Responsive size = Responsive(context);

    return Scaffold(
      body: FutureBuilder<List<City>>(
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
                return GestureDetector(
                  onTap: () {
                    close(context, city);
                    logicController.getDataCity(city.name);
                  },
                  child: ResultCard(
                    city: city.name!,
                    isSelected: selectedCities.contains(city.name),
                    onSelected: (isSelected) {
                      if (isSelected) {
                        selectedCities.add(city.name!);
                      } else {
                        selectedCities.remove(city.name);
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: buildFloatingActionButton(context),
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

    return Scaffold(
      body: FutureBuilder<List<City>>(
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
                return GestureDetector(
                  onTap: () {
                    close(context, city);
                    logicController.getDataCity(city.name);
                  },
                  child: ResultCard(
                    city: city.name!,
                    isSelected: selectedCities.contains(city.name),
                    onSelected: (isSelected) {
                      if (isSelected) {
                        selectedCities.add(city.name!);
                      } else {
                        selectedCities.remove(city.name);
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }
}
