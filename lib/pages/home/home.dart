import '../../export.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.selectedCities});
  final List<String>? selectedCities;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedCities = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive(context);
    final responsecity = Provider.of<LogicController>(context);
    final city = responsecity.currentCity;
    final weatherForecast = responsecity.weatherForecast;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: size.width,
                  height: size.height * 0.1,
                  color: const Color(0x5D80E3EC),
                  child: Center(
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Search(),
                city == null
                    ? const Center(child: CircularProgressIndicator())
                    : CardTemp(city: city),
                const SizedBox(
                  height: 20,
                ),
                const DropdownCustom(),
                const SizedBox(
                  height: 60,
                ),
                weatherForecast != null
                    ? SizedBox(
                        height: 120,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              weatherForecast.length,
                              (index) => WeatherCard(
                                temperature: weatherForecast[index]
                                    ['temperature'],
                                day: weatherForecast[index]['day'],
                              ),
                            ),
                          ),
                        ),
                      )
                    : const WeatherCard(
                        temperature: 0,
                        day: "Datos No encontrados",
                      ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => responsecity.getCurrentLocation(),
          child: const Icon(Icons.add_location_rounded),
        ),
        bottomNavigationBar: ButtonNavigator(),
      ),
    );
  }
}
