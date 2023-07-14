

import '../export.dart';

class AddFavorites extends StatelessWidget {
  const AddFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("No tienes ciudades en favoritos"),
        GestureDetector(
          onTap: () =>
              showSearch(context: context, delegate: CitySearchDelegate()),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: const Text(
              "Agregar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
