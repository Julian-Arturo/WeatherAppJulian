import '../export.dart';

class CardTemp extends StatelessWidget {
  CardTemp({
    Key? key,
    required this.city,
  }) : super(key: key);

  final WeatherData city;

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive(context);
    String iconCode = city.weather![0].icon!;
    final isLargeScreen = size.width > 600;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          width: isLargeScreen ? size.width * 0.3 : size.width,
          height: isLargeScreen ? size.height * 0.3 : size.height * 0.25,
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
          top: isLargeScreen ? size.height * 0.06 : size.height * 0.05,
          child: SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  getWeatherIcon(iconCode),
                  width: isLargeScreen ? size.width * 0.1 : size.width * 0.28,
                ),
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
                    "${city.main!.temp!.toStringAsFixed(2).substring(0, 2)}°",
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
          top: isLargeScreen ? size.height * 0.25 : size.height * 0.18,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " ${city.name!.toUpperCase()}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    city.weather![0].description!,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
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

  String getWeatherIcon(String iconCode) {
    // Mapear los códigos de iconos a las imágenes correspondientes
    switch (iconCode) {
      case "01d":
        return "assets/images/sunny.png";
      case "01n":
        return "assets/images/moon.png";
      case "02d":
        return "assets/images/sol.png";
      case "02n":
        return "assets/images/nochenube.png";
      case "03d":
      case "03n":
        return "assets/images/nube.png";
      case "04d":
      case "04n":
        return "assets/images/nubecasi.png";
      case "09d":
      case "09n":
        return "assets/images/nubelluviosa.png";
      case "10d":
        return "assets/images/Lrain.png";
      case "10n":
        return "assets/images/Lrain1.png";
      case "11d":
        return "assets/images/hail.png";
      case "11n":
        return "assets/images/hail0.png";
      case "13d":
        return "assets/images/snow.png";
      case "13n":
        return "assets/images/SnowN.png";
      case "50d":
        return "assets/images/Foggy.png";
      case "50n":
        return "assets/images/foggy0.png";
      default:
        return "assets/images/sunny.png";
    }
  }
}
