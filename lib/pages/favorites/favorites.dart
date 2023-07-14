

import '../../export.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive(context);
    final responsecity = Provider.of<LogicController>(context);
    List<String> selectedCities = responsecity.getSelectedCities();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: size.width,
              height: size.height * 0.1,
              color: const Color(0x5D80E3EC),
              child: Center(
                child: Text(
                  "Favorites Cities",
                  style: TextStyle(
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: selectedCities.length,
              itemBuilder: (context, index) {
                String city = selectedCities[index];
                return ListTile(
                  title: Container(
                    height: 80,
                    width: size.width * 0.8,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          city,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Center(child: IconButton(onPressed: ()=> responsecity.removeSelectedCity(city), icon: const Icon(Icons.highlight_remove_rounded, color: Colors.red, size: 20,)))
                      ],
                    ),
                  ),
                  onTap: () {
                    responsecity.getDataCity(city);
                    Navigator.pushNamed(context, "home");
                    responsecity.changeIndex(0);
                  },
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: ButtonNavigator(),
      ),
    );
  }
}
