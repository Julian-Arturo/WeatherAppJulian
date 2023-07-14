

import '../export.dart';

class ButtonNavigator extends StatefulWidget {
  @override
  State<ButtonNavigator> createState() => _ButtonNavigatorState();
}

class _ButtonNavigatorState extends State<ButtonNavigator> {
  @override
  Widget build(BuildContext context) {
    final change = Provider.of<LogicController>(context);

    return BottomNavigationBar(
      currentIndex: change.currentIndex,
      onTap: (index) {
        change.changeIndex(index);

        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesPage()),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
      
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
    );
  }
}
