import '../export.dart';

class WeatherCard extends StatelessWidget {
  final double temperature;
  final String day;

  const WeatherCard({
    super.key,
    required this.temperature,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive(context);

    return Container(
      width: size.width * 0.3,
      height: size.height * 0.25,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(112, 158, 158, 158),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$temperature°C',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            day,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
