
import 'package:http/http.dart' as http;

import '../export.dart';

class LogicController extends ChangeNotifier {
  Logger logger = Logger();
  static const String baseUrl = "https://api.openweathermap.org";
  final apiKey = '3719358a9bad2da40d568ec4f64b9a67';
  WeatherData? currentCity;
  int currentIndex = 0;
  List<dynamic>? weatherForecast;

  LogicController() {
    getCurrentLocation();
    getWeatherForecast();
  }

  /// Busca ciudades que coincidan con el texto de búsqueda.
  /// Retorna una lista de objetos de tipo `City`.
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

  /// Obtiene los datos del clima para una ciudad específica.
  Future<void> getDataCity(String? cityName) async {
    try {
      cityName ??= "Bucaramanga";

      var url =
          Uri.parse('$baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = response.body;
        final weatherData = WeatherData.fromJson(json);
        currentCity = weatherData;
        notifyListeners();
      } else {
        throw Exception('Failed to fetch city data');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Obtiene el pronóstico del clima para la ciudad actual.
  /// Retorna una lista de objetos dinámicos.
  Future<List<dynamic>> getWeatherForecast() async {
    final apiUrl =
        '$baseUrl/data/2.5/forecast/daily?q=${currentCity!.name}&cnt=8&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        weatherForecast =
            jsonData['list']; // Actualizar el valor de weatherForecast
        return weatherForecast!;
      } else {
        throw Exception('Error al obtener el pronóstico del clima');
      }
    } catch (e) {
      throw Exception('Error de conexión');
    }
  }

  /// Obtiene la ubicación actual del dispositivo y los datos de la ciudad correspondiente.
  Future<void> getCurrentLocation() async {
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

  List<String> selectedCities = [];

  /// Agrega una ciudad a la lista de ciudades seleccionadas.
  void addSelectedCity(String city) {
    selectedCities.add(city);
    notifyListeners();
  }

  /// Elimina una ciudad de la lista de ciudades seleccionadas.
  void removeSelectedCity(String city) {
    selectedCities.remove(city);
    notifyListeners();
  }

  /// Retorna la lista de ciudades seleccionadas.
  List<String> getSelectedCities() {
    return selectedCities;
  }

  /// Cambia el índice actual.
  void changeIndex(int index) {
    currentIndex = index;
  }
}
