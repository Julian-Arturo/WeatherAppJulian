import '../export.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "getStarted": (_) => const GetStartedPage(),
  "home": (_) => const HomePage(),
  "city": (_) => const FavoritesPage(),
};
